//
//  NSString+CLJIndexed.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/23/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSString+CLJIndexed.h"
#import "NSString+CLJCounted.m"


@implementation NSString (CLJIndexed)

- (id)nth:(NSUInteger)index
{
    return [self substringWithRange:(NSRange){ .location = index, .length = 1 }];
}

- (id)nth:(NSUInteger)index withDefault:(id)notFound
{
    return [self nth:index] ?: notFound;
}

@end
