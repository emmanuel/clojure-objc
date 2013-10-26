//
//  CLJPersistentHashMap.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJPersistentHashMap.h"
#import "CLJPersistentHashMapBitmapIndexedNode.h"
#import "CLJMapEntry.h"
#import "CLJPersistentHashMapUtils.h"

@protocol CLJIPersistentHashMapNode;



@interface CLJPersistentHashMap ()

@property (nonatomic) NSUInteger count;
@property (nonatomic, strong) id<CLJIPersistentHashMapNode> root;
@property (nonatomic) BOOL hasNil;
@property (nonatomic, strong) id nilValue;
@property (nonatomic, strong) id<CLJIPersistentMap> meta;

@end


@implementation CLJPersistentHashMap

#pragma mark - Singleton methods

+ (CLJPersistentHashMap *)empty
{
    static CLJPersistentHashMap *empty;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        empty = [[self alloc] initWithMeta:nil count:0 rootNode:nil hasNilValue:NO nilValue:nil];
    });

    return empty;
}

+ (id)notFound
{
    static id notFound = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notFound = [NSObject new];
    });

    return notFound;
}

#pragma mark - Factory methods

+ (instancetype)hashMapWithMeta:(id<CLJIPersistentMap>)meta count:(NSUInteger)count rootNode:(id<CLJIPersistentHashMapNode>)root hasNilValue:(BOOL)hasNilValue nilValue:(id)nilValue
{
    return [[self alloc] initWithMeta:meta count:count rootNode:root hasNilValue:hasNilValue nilValue:nilValue];
}

#pragma mark - Initialization methods

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta count:(NSUInteger)count rootNode:(id<CLJIPersistentHashMapNode>)root hasNilValue:(BOOL)hasNilValue nilValue:(id)nilValue
{
    if (self = [super init])
    {
        self.meta = meta;
        self.count = count;
        self.root = root;
        self.hasNil = hasNilValue;
        self.nilValue = nilValue;
    }

    return self;
}

#pragma mark - CLJIObj

- (instancetype)withMeta:(id<CLJIPersistentMap>)meta
{
    return [[self class] hashMapWithMeta:meta count:self.count rootNode:self.root hasNilValue:self.hasNil nilValue:self.nilValue];
}

#pragma mark - CLJIPersistentMap

- (instancetype)assocKey:(id)key withObject:(id)object
{
    if (nil == key)
    {
        if (self.hasNil && (self.nilValue == object)) return self;

        return [CLJPersistentHashMap hashMapWithMeta:self.meta
                                               count:self.count
                                            rootNode:self.root
                                         hasNilValue:YES
                                            nilValue:object];
	}
    BOOL addedLeaf = NO;
    id<CLJIPersistentHashMapNode> newRoot = self.root ?: [CLJPersistentHashMapBitmapIndexedNode empty];
    newRoot = [newRoot assocKey:key withObject:object shift:0 hash:[key hash] addedLeaf:&addedLeaf];
    if (newRoot == self.root) return self;
    return [CLJPersistentHashMap hashMapWithMeta:self.meta count:(self.count + (addedLeaf ? 1 : 0)) rootNode:newRoot hasNilValue:self.hasNil nilValue:self.nilValue];
}

- (BOOL)containsKey:(id)key
{
    if (nil == key) return self.hasNil;
    if (nil == self.root) return NO;

    id notFound = [CLJPersistentHashMap notFound];
    id found = [self.root findKey:key shift:0 hash:[key hash] notFound:notFound];
    return notFound != found;
}

- (id<CLJIMapEntry>)entryAt:(id)key
{
    if (nil == key) return self.hasNil ? [CLJMapEntry mapEntryWithKey:nil object:self.nilValue] : nil;
    return [self.root findKey:key shift:0 hash:[key hash]];
}

@end
