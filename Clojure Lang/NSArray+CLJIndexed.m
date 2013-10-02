//
//  NSArray+CLJNth.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/23/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSArray+CLJIndexed.h"

@implementation NSArray (CLJIndexed)

- (id)nth:(NSInteger)i
{
    return [self objectAtIndex:i];
}

- (id)nth:(NSInteger)i withDefault:(id)notFound
{
    return [self objectAtIndex:i] ?: notFound;
}

@end
