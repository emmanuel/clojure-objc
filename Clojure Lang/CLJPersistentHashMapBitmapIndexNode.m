//
//  CLJPersistentHashMapBitmapIndexNode.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJPersistentHashMapBitmapIndexNode.h"

@interface CLJPersistentHashMapBitmapIndexNode ()

@property (atomic) NSThread *editThread;
@property (nonatomic) NSInteger bitmap;
@property (nonatomic) NSArray *array;

@end


@implementation CLJPersistentHashMapBitmapIndexNode

#pragma mark - Singleton methods

+ (instancetype)empty
{
    static CLJPersistentHashMapBitmapIndexNode *emptyNode;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        emptyNode = [[self alloc] initWithEditThread:nil bitmap:0 array:@[]];
    });

    return emptyNode;
}

#pragma mark - Initialization methods

- (instancetype)initWithEditThread:(NSThread *)editThread bitmap:(NSInteger)bitmap array:(NSArray *)array
{
    if (self = [super init])
    {
        self.editThread = editThread;
        self.bitmap = bitmap;
        self.array = array;
    }

    return self;
}

#pragma mark - CLJIPersistentHashMapINode methods

- (id<CLJPersistentHashMapINode>)assocWithShift:(NSInteger)shift
                                           hash:(NSInteger)hash
                                            key:(id)key
                                          value:(id)val
                                      addedLeaf:(id)addedLeaf
{
    return nil;
//    int bit = bitpos(hash, shift);
//    int idx = index(bit);
//    if((bitmap & bit) != 0) {
//        Object keyOrNull = array[2*idx];
//        Object valOrNode = array[2*idx+1];
//        if(keyOrNull == null) {
//            INode n = ((INode) valOrNode).assoc(shift + 5, hash, key, val, addedLeaf);
//            if(n == valOrNode)
//                return this;
//            return new BitmapIndexedNode(null, bitmap, cloneAndSet(array, 2*idx+1, n));
//        }
//        if(Util.equiv(key, keyOrNull)) {
//            if(val == valOrNode)
//                return this;
//            return new BitmapIndexedNode(null, bitmap, cloneAndSet(array, 2*idx+1, val));
//        }
//        addedLeaf.val = addedLeaf;
//        return new BitmapIndexedNode(null, bitmap,
//                                     cloneAndSet(array,
//                                                 2*idx, null,
//                                                 2*idx+1, createNode(shift + 5, keyOrNull, valOrNode, hash, key, val)));
//    } else {
//        int n = Integer.bitCount(bitmap);
//        if(n >= 16) {
//            INode[] nodes = new INode[32];
//            int jdx = mask(hash, shift);
//            nodes[jdx] = EMPTY.assoc(shift + 5, hash, key, val, addedLeaf);
//            int j = 0;
//            for(int i = 0; i < 32; i++)
//                if(((bitmap >>> i) & 1) != 0) {
//                    if (array[j] == null)
//                        nodes[i] = (INode) array[j+1];
//                    else
//                        nodes[i] = EMPTY.assoc(shift + 5, hash(array[j]), array[j], array[j+1], addedLeaf);
//                    j += 2;
//                }
//            return new ArrayNode(null, n + 1, nodes);
//        } else {
//            Object[] newArray = new Object[2*(n+1)];
//            System.arraycopy(array, 0, newArray, 0, 2*idx);
//            newArray[2*idx] = key;
//            addedLeaf.val = addedLeaf; 
//            newArray[2*idx+1] = val;
//            System.arraycopy(array, 2*idx, newArray, 2*(idx+1), 2*(n-idx));
//            return new BitmapIndexedNode(null, bitmap | bit, newArray);
//        }
//    }
}

- (NSInteger)bitposWithHash:(NSInteger)hash shift:(NSInteger)shift
{
    return 1 << mask(hash, shift);
}

@end
