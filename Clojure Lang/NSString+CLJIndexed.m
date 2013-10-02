//
//  NSString+CLJIndexed.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/23/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSString+CLJCounted.h"
#import "NSString+CLJIndexed.h"


@implementation NSString (CLJIndexed)

- (id)nth:(NSUInteger)index
{
    return [self substringWithRange:NSMakeRange(index, 1)];
}

- (id)nth:(NSUInteger)index withDefault:(id)notFound
{
    return [self nth:index] ?: notFound;
}

@end
