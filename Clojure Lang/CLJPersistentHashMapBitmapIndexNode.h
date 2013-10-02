//
//  CLJPersistentHashMapBitmapIndexNode.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJPersistentHashMapINode.h"

@interface CLJPersistentHashMapBitmapIndexNode : NSObject <CLJPersistentHashMapINode>

+ (instancetype)empty;

- (instancetype)initWithEditThread:(NSThread *)editThread bitmap:(NSInteger)bitmap array:(NSArray *)array;

@end
