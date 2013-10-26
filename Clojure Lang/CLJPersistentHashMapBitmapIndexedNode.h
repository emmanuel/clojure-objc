//
//  CLJPersistentHashMapBitmapIndexNode.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIPersistentHashMapNode.h"

@interface CLJPersistentHashMapBitmapIndexedNode : NSObject <CLJIPersistentHashMapNode>

+ (instancetype)empty;
+ (instancetype)nodeWithEditThread:(CLJAtomicReference *)editThread bitmap:(NSUInteger)bitmap array:(NSPointerArray *)array;

- (instancetype)initWithEditThread:(CLJAtomicReference *)editThread bitmap:(NSUInteger)bitmap array:(NSPointerArray *)array;

@end
