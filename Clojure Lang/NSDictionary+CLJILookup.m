//
//  NSDictionary+CLJILookup.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//


#import "NSDictionary+CLJILookup.h"

@implementation NSDictionary (CLJILookup)

- (id)get:(id)key
{
    return [self objectForKey:key];
}

@end
