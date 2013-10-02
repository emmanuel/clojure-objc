//
//  CLJArrayNode.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJPersistentHashMapINode.h"


@interface CLJPersistentHashMapArrayNode : NSObject <CLJPersistentHashMapINode>

- (instancetype)initWithEditThread:(NSThread *)editThread count:(NSInteger)count array:(NSArray *)array;

@end
