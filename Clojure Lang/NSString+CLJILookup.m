//
//  NSString+CLJILookup.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSObject+CLJILookup.m"
#import "NSString+CLJILookup.h"
#import "NSString+CLJIndexed.h"


@implementation NSString (CLJILookup)

- (id)get:(id)key
{
    if ([key isKindOfClass:[NSNumber class]])
    {
        NSInteger n = [key integerValue];
        
        if (0 <= n < [self length])
        {
            return [self nth:n];
        }
    }

    return nil;
}

@end
