//
//  CLJPersistentHashMap.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJPersistentHashMap.h"

@protocol CLJPersistentHashMapINode;


@interface CLJPersistentHashMap ()
{
    NSUInteger _count;
    id<CLJPersistentHashMapINode> _root;
    BOOL _hasNil;
    id _nilValue;
    id<CLJIPersistentMap> _meta;
}

@end


@implementation CLJPersistentHashMap

#pragma mark - Singleton methods

+ (CLJPersistentHashMap *)empty
{
    static CLJPersistentHashMap *empty;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        empty = [[self alloc] initWithCount:0 root:nil hasNilValue:NO nilValue:nil];
    });

    return empty;
}

#pragma mark - Initialization methods

- (instancetype)initWithCount:(NSUInteger)count
                         root:(id <CLJPersistentHashMapINode>)root
                  hasNilValue:(BOOL)hasNilValue
                     nilValue:(id)nilValue
{
    if (self = [super init])
    {
        _count = count;
        _root = root;
        _hasNil = hasNilValue;
        _nilValue = nilValue;
        _meta = nil;
    }
    
    return self;
}

- (instancetype)initWithMeta:(id <CLJIPersistentMap>)meta
                       count:(NSUInteger)count
                        root:(id <CLJPersistentHashMapINode>)root
                 hasNilValue:(BOOL)hasNilValue
                    nilValue:(id)nilValue
{
    if (self = [self initWithCount:count
                              root:root
                       hasNilValue:hasNilValue
                          nilValue:nilValue])
    {
        _meta = meta;
    }

    return self;
}

- (id<CLJIPersistentMap>)assocKey:(id)key withValue:(id)value
{
    return nil;
    if (nil == key)
    {
        if (_hasNil && (value == _nilValue))
        {
			return self;
        }
		return [[CLJPersistentHashMap alloc] initWithMeta:_meta
                                                    count:_count
                                                     root:_root
                                              hasNilValue:YES
                                                 nilValue:value];
	}
//	Box addedLeaf = new Box(null);
//	INode newroot = (root == null ? BitmapIndexedNode.EMPTY : root)
//    .assoc(0, hash(key), key, val, addedLeaf);
//	if(newroot == root)
//		return this;
//	return new PersistentHashMap(meta(), addedLeaf.val == null ? count : count + 1, newroot, hasNull, nullValue);

}

@end
