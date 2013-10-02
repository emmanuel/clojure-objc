//
//  CLJPersistentVectorNode.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/1/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJPersistentVectorConstants.h"


@interface CLJPersistentVectorNode : NSObject <NSCoding>

@property (atomic, strong) NSThread *editThread;
@property (nonatomic, strong) NSArray *array;

+ (instancetype)empty;
+ (instancetype)nodeWithEditThread:(NSThread *)editThread array:(NSArray *)array;

- (instancetype)initWithEditThread:(NSThread *)editThread array:(NSArray *)array;
- (instancetype)nodeWithArray:(NSArray *)array;

@end
