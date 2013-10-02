//
//  NSArray+CLJILookup.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSArray+CLJILookup.h"
#import "NSArray+CLJIndexed.h"

@implementation NSArray (CLJILookup)

- (id)get:(id)key
{
    if ([key isKindOfClass:[NSNumber class]])
    {
        NSInteger n = [key integerValue];
        
        if (0 <= n < [self count])
        {
            return [self nth:n];
        }
    }

    return nil;
}

- (id)get:(id)key withDefault:(id)notFound
{
    return [self get:key] ?: notFound;
}

@end
