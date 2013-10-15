//
//  CLJPersistentHashMap.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAPersistentMap.h"
#import "CLJIEditableCollection.h"
#import "CLJIObj.h"

@protocol CLJIPersistentHashMapNode;
@protocol CLJISeq;

@interface CLJPersistentHashMap : CLJAPersistentMap <CLJIEditableCollection, CLJIObj>

+ (instancetype)empty;
+ (id)notFound;

+ (instancetype)createWithKeysAndValues:(id)arg, ... NS_REQUIRES_NIL_TERMINATION;
+ (instancetype)createAndCheckWithKeysAndValues:(id)arg, ... NS_REQUIRES_NIL_TERMINATION;
+ (instancetype)createWithSeq:(id<CLJISeq>)seq;
+ (instancetype)createAndCheckWithSeq:(id <CLJISeq>)seq;

+ (instancetype)createWithMeta:(id<CLJIPersistentMap>)meta keysAndValues:(id)arg, ... NS_REQUIRES_NIL_TERMINATION;
+ (instancetype)createAndCheckWithMeta:(id <CLJIPersistentMap>)meta seq:(id <CLJISeq>)seq;

+ (instancetype)hashMapWithMeta:(id<CLJIPersistentMap>)meta count:(NSUInteger)count rootNode:(id<CLJIPersistentHashMapNode>)root hasNilValue:(BOOL)hasNilValue nilValue:(id)nilValue;

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta count:(NSUInteger)count rootNode:(id<CLJIPersistentHashMapNode>)root hasNilValue:(BOOL)hasNilValue nilValue:(id)nilValue;

@end
