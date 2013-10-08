//
//  NSArray+ArrayWithChanges.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/6/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSArray+ArrayWithChanges.h"

@implementation NSArray (ArrayWithChanges)

- (NSArray *)arrayWithIndex:(NSUInteger)index setToObject:(id)object
{
    NSMutableArray *temp = [self mutableCopy];
    [temp replaceObjectAtIndex:index withObject:object];
    return [NSArray arrayWithArray:temp];
}

- (NSArray *)arrayWithObject:(id)object atIndex:(NSUInteger)index
{
    return [self arrayWithIndex:index setToObject:object];
}

@end
