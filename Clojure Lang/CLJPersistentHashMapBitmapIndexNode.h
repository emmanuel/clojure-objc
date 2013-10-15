//
//  CLJPersistentHashMapBitmapIndexNode.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIPersistentHashMapNode.h"

@interface CLJPersistentHashMapBitmapIndexNode : NSObject <CLJIPersistentHashMapNode>

+ (instancetype)empty;
+ (instancetype)nodeWithEditThread:(NSThread *)editThread bitmap:(NSUInteger)bitmap array:(NSPointerArray *)array;

- (instancetype)initWithEditThread:(NSThread *)editThread bitmap:(NSUInteger)bitmap array:(NSPointerArray *)array;

@end
