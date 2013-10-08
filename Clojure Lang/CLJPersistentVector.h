//
//  CLJPersistentVector.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/30/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAPersistentVector.h"
#import "CLJPersistentVectorConstants.h"


@class CLJPersistentVectorNode;

@interface CLJPersistentVector : CLJAPersistentVector

+ (instancetype)empty;
+ (instancetype)vectorWithMeta:(id<CLJIPersistentMap>)meta count:(NSUInteger)count shift:(NSUInteger)shift root:(CLJPersistentVectorNode *)root tail:(NSArray *)tail;

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta count:(NSUInteger)count shift:(NSUInteger)shift root:(CLJPersistentVectorNode *)root tail:(NSArray *)tail;

- (CLJPersistentVector *)cons:(id)object;
- (CLJPersistentVector *)assocN:(NSUInteger)index withObject:(id)object;

@end
