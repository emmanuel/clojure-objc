//
//  NSArray+CLJILookup.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSArray+CLJILookup.h"
#import "NSArray+CLJIndexed.h"
#import "NSObject+CLJILookup.m"

@implementation NSArray (CLJILookup)

- (id)get:(id)key
{
    if ([key isKindOfClass:[NSNumber class]])
    {
        NSUInteger n = [key unsignedIntegerValue];
        
        if (n < [self count]) return [self nth:n];
    }

    return nil;
}

@end
