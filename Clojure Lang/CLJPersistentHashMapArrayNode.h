//
//  CLJArrayNode.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIPersistentHashMapNode.h"


@interface CLJPersistentHashMapArrayNode : NSObject <CLJIPersistentHashMapNode>

+ (instancetype)nodeWithEditThread:(NSThread *)editThread count:(NSUInteger)count array:(NSPointerArray *)array;

- (instancetype)initWithEditThread:(NSThread *)editThread count:(NSUInteger)count array:(NSPointerArray *)array;

@end
