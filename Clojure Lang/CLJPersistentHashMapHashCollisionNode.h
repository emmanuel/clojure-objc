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

//HashCollisionNode(AtomicReference<Thread> edit, int hash, int count, Object... array){

+ (instancetype)nodeWithEditThread:(NSThread *)editThread hash:(NSUInteger)hash count:(NSUInteger)count objects:(NSArray *)objects;
//+ (instancetype)nodeWithEditThread:(NSThread *)editThread hash:(NSUInteger)hash count:(NSUInteger)count keysAndObjects:(id)object1, ... NS_REQUIRES_NIL_TERMINATION;

@end
