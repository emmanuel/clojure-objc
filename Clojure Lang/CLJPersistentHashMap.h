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

// TODO: add transient support and conform to CLJIEditableCollection protocol
@interface CLJPersistentHashMap : CLJAPersistentMap <CLJIObj>

+ (instancetype)empty;
+ (id)notFound;

+ (instancetype)hashMapWithMeta:(id<CLJIPersistentMap>)meta count:(NSUInteger)count rootNode:(id<CLJIPersistentHashMapNode>)root hasNilValue:(BOOL)hasNilValue nilValue:(id)nilValue;

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta count:(NSUInteger)count rootNode:(id<CLJIPersistentHashMapNode>)root hasNilValue:(BOOL)hasNilValue nilValue:(id)nilValue;

@end
