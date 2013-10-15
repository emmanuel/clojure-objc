//
//  NSArray+ArrayWithChanges.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/6/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSArray+ArrayWithChanges.h"

@implementation NSArray (ArrayWithChanges)

- (instancetype)arrayWithIndex:(NSUInteger)index setToObject:(id)object
{
    NSMutableArray *temp = [self mutableCopy];
    [temp replaceObjectAtIndex:index withObject:object];
    return [[self class] arrayWithArray:temp];
}

- (instancetype)arrayWithObject:(id)object atIndex:(NSUInteger)index
{
    return [self arrayWithIndex:index setToObject:object];
}

- (instancetype)arrayByRemovingLastObject
{
    // return [self subarrayWithRange:NSMakeRange(0, [self count] - 1)];
    return [self subarrayWithRange:(NSRange){ .location = 0, .length = ([self count] - 1) }];
}

@end
