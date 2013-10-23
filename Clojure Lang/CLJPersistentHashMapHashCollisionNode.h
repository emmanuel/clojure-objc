//
//  CLJPersistentHashMapHashCollisionNode.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/14/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIPersistentHashMapNode.h"


@interface CLJPersistentHashMapHashCollisionNode : NSObject <CLJIPersistentHashMapNode>

+ (instancetype)nodeWithEditThread:(CLJAtomicReference *)editThread hash:(NSUInteger)hash count:(NSUInteger)count objects:(NSArray *)objects;

- (instancetype)initWithEditThread:(CLJAtomicReference *)editThread hash:(NSUInteger)hash count:(NSUInteger)count objects:(NSArray *)objects;

@end
