//
//  CLJPersistentHashMapBitmapIndexNode.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJUtil.h"
#import "CLJCategories.h"
#import "CLJPersistentHashMapUtils.m"
#import "CLJPersistentHashMapBitmapIndexNode.h"
#import "CLJPersistentHashMapArrayNode.h"
#import "CLJPersistentHashMapHashCollisionNode.h"
#import "CLJMapEntry.h"


@interface CLJPersistentHashMapBitmapIndexNode ()

@property (atomic) CLJAtomicReference *editThread;
@property (nonatomic) NSUInteger bitmap;
@property (nonatomic) NSPointerArray *array;

@end


@implementation CLJPersistentHashMapBitmapIndexNode

#pragma mark - Singleton methods

+ (instancetype)empty
{
    static CLJPersistentHashMapBitmapIndexNode *emptyNode;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        emptyNode = [[self alloc] initWithEditThread:nil
                                             bitmap:0
                                               array:[NSPointerArray strongObjectsPointerArray]];
    });

    return emptyNode;
}

#pragma mark - Initialization methods

+ (instancetype)nodeWithEditThread:(CLJAtomicReference *)editThread bitmap:(NSUInteger)bitmap array:(NSPointerArray *)array
{
    return [[self alloc] initWithEditThread:editThread bitmap:bitmap array:array];
}

- (instancetype)initWithEditThread:(CLJAtomicReference *)editThread bitmap:(NSUInteger)bitmap array:(NSPointerArray *)array
{
    if (self = [super init])
    {
        self.editThread = editThread;
        self.bitmap = bitmap;
        self.array = array;
    }

    return self;
}

#pragma mark - CLJIPersistentHashMapNode methods

- (NSUInteger)indexOfBit:(NSUInteger)bit
{
    return CLJPersistentHashMapUtil_bitPopulation(self.bitmap & (bit - 1));
}

- (id<CLJIPersistentHashMapNode>)assocKey:(id)key withObject:(id)object shift:(NSUInteger)shift hash:(NSUInteger)hash addedLeaf:(BOOL *)addedLeaf
{
    NSUInteger bitmap = self.bitmap;
    NSUInteger bit = CLJPersistentHashMapUtil_bitpos(hash, shift);
    // how many bits below this one are set in the bitmask? (index of key in self.array)
    NSUInteger index = CLJPersistentHashMapUtil_bitRank(bitmap, bit);

    // replace the node on this level
    if ((bitmap & bit) != 0)
    {
        id keyOrNil = [self.array pointerAtIndex:2 * index];
        id objectOrNode = [self.array pointerAtIndex:(2 * index) + 1];
        // en route to leaf (k/v pair), continue copying path
        if (nil == keyOrNil)
        {
            id<CLJIPersistentHashMapNode> currentNode = (id<CLJIPersistentHashMapNode>)objectOrNode;
            id<CLJIPersistentHashMapNode> newNode = [currentNode assocKey:key
                                                               withObject:object
                                                                    shift:shift + 5
                                                                     hash:hash
                                                                addedLeaf:addedLeaf];
            if (newNode == objectOrNode) return self;
            NSPointerArray *newArray = [self.array copy];
            [newArray replacePointerAtIndex:(2 * index) + 1 withPointer:(__bridge void *)newNode];
            return [CLJPersistentHashMapBitmapIndexNode nodeWithEditThread:nil bitmap:self.bitmap array:newArray];
        }
        // leaf (k/v pair) located, replace existing value
        if (CLJUtil_equiv(key, keyOrNil))
        {
            if (object == objectOrNode) return self;
            NSPointerArray *newArray = [_array copy];
            [newArray replacePointerAtIndex:(2 * index) + 1 withPointer:(__bridge void *)object];
            return [CLJPersistentHashMapBitmapIndexNode nodeWithEditThread:nil
                                                                   bitmap:self.bitmap
                                                                     array:newArray];
        }
        // place leaf (k/v pair) in replacement node's array
        *addedLeaf = YES;
        NSPointerArray *newArray = [_array copy];
        [newArray replacePointerAtIndex:2 * index withPointer:(void *)nil];
        id<CLJIPersistentHashMapNode> newNode = [self createNodeWithShift:shift + 5 key1:keyOrNil object1:objectOrNode key2Hash:hash key2:key object2:object];
        [newArray replacePointerAtIndex:(2 * index) + 1 withPointer:(__bridge void *)newNode];
        return [CLJPersistentHashMapBitmapIndexNode nodeWithEditThread:nil bitmap:self.bitmap array:newArray];
    }
    // add branches below this node
    else
    {
        NSUInteger numberOfSlotsOccupied = CLJPersistentHashMapUtil_bitPopulation(self.bitmap);
        // full; promote to array node
        if (16 <= numberOfSlotsOccupied)
        {
            NSPointerArray *nodes = [NSPointerArray strongObjectsPointerArray];
            [nodes setCount:32];
            NSUInteger jdx = CLJPersistentHashMapUtil_mask(hash, shift);
            id<CLJIPersistentHashMapNode> newNode = [CLJPersistentHashMapBitmapIndexNode empty];
            newNode = [newNode assocKey:key withObject:object shift:shift + 5 hash:hash addedLeaf:addedLeaf];
            [nodes replacePointerAtIndex:jdx withPointer:(__bridge void *)newNode];
            NSUInteger j = 0;
            NSUInteger bitmap = self.bitmap;
            NSPointerArray *array = self.array;
            for (NSUInteger i = 0; i < 32; i++) {
                // populated at position i
                if (((bitmap >> i) & 1) != 0)
                {
                    // node in position (reference in new array node)
                    if (nil == [array pointerAtIndex:j])
                    {
                        [nodes replacePointerAtIndex:i withPointer:[array pointerAtIndex:j + 1]];
                    }
                    // key in position (replace k/v pair with bitmap index node in new array node)
                    else
                    {
                        id key = [array pointerAtIndex:j];
                        id<CLJIPersistentHashMapNode> newNode = [CLJPersistentHashMapBitmapIndexNode empty];
                        newNode = [newNode assocKey:key withObject:[array pointerAtIndex:j + 1] shift:shift + 5 hash:[key clj_hasheq] addedLeaf:addedLeaf];
                        [nodes replacePointerAtIndex:i withPointer:(__bridge void *)newNode];
                    }
                    j += 2;
                }
            }
            return [CLJPersistentHashMapArrayNode nodeWithEditThread:nil count:numberOfSlotsOccupied + 1 array:nodes];
        }
        else
        {
            NSPointerArray *newArray = [self.array copy];
            [newArray insertPointer:(__bridge void *)key atIndex:2 * index];
            [newArray insertPointer:(__bridge void *)object atIndex:(2 * index) + 1];
            *addedLeaf = YES;

            return [CLJPersistentHashMapBitmapIndexNode nodeWithEditThread:nil bitmap:bitmap array:newArray];
        }
    }
}

- (id<CLJIPersistentHashMapNode>)createNodeWithShift:(NSUInteger)shift key1:(id)key1 object1:(id)object1 key2Hash:(NSUInteger)key2Hash key2:(id)key2 object2:(id)object2
{
    NSUInteger key1Hash = 0;
    if (key1Hash == key2Hash) return [CLJPersistentHashMapHashCollisionNode nodeWithEditThread:nil hash:key1Hash count:2 objects:@[ key1, object1, key2, object2 ]];
    BOOL _ = NO;
    return [[[CLJPersistentHashMapBitmapIndexNode empty]
                assocKey:key1 withObject:object1 shift:shift hash:key1Hash addedLeaf:&_]
                assocKey:key2 withObject:object2 shift:shift hash:key2Hash addedLeaf:&_];
}

- (id<CLJIMapEntry>)findKey:(id)key shift:(NSUInteger)shift hash:(NSUInteger)hash
{
    NSPointerArray *array = self.array;
    NSUInteger bitmap = self.bitmap;
    NSUInteger bit = CLJPersistentHashMapUtil_bitpos(hash, shift);
    if ((bitmap & bit) == 0) return nil;
    NSUInteger index = CLJPersistentHashMapUtil_bitRank(bitmap, bit);
    id keyOrNil = [array pointerAtIndex:2 * index];
    id valOrNode = [array pointerAtIndex:(2 * index) + 1];
    if (keyOrNil == nil) return [(id<CLJIPersistentHashMapNode>)valOrNode findKey:key shift:shift + 5 hash:hash];
    if (CLJUtil_equiv(key, keyOrNil)) return [CLJMapEntry mapEntryWithKey:keyOrNil object:valOrNode];
    return nil;
}

- (id)findKey:(id)key shift:(NSUInteger)shift hash:(NSUInteger)hash notFound:(id)notFound
{
    return [self findKey:key shift:shift hash:hash] ?: notFound;
}

@end
