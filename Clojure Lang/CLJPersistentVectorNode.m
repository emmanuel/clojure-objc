//
//  CLJPersistentVectorNode.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/1/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJPersistentVectorNode.h"

#pragma mark - CLJPersistentVectorNode holds state in the vector

@implementation CLJPersistentVectorNode

#pragma mark - Singleton methods

+ (instancetype)empty
{
    static CLJPersistentVectorNode *emptyNode;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emptyNode = [self nodeWithEditThread:nil array:@[ ]];
    });
    
    return emptyNode;
}

#pragma mark - Initialization methods

+ (instancetype)nodeWithEditThread:(NSThread *)editThread array:(NSArray *)array
{
    return [[self alloc] initWithEditThread:editThread array:array];
}

- (instancetype)initWithEditThread:(NSThread *)editThread array:(NSMutableArray *)array
{
    if (self = [super init])
    {
        self.editThread = editThread;
        self.array = array;
    }
    
    return self;
}

- (instancetype)nodeWithArray:(NSArray *)array
{
    return [[self class] nodeWithEditThread:self.editThread array:array];
}

@end
