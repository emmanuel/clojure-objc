//
//  NSObject+CLJILookup.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSObject+CLJILookup.h"

@implementation NSObject (CLJILookup)

- (id)get:(id)key
{
    // TODO: should this be `[self valueForKey:]`
    // OR: `[self doesNotRecognizeSelector:_cmd]`
    // instead?
    return nil;
}

- (id)get:(id)key withDefault:(id)notFound
{
    return [self get:key] ?: notFound;
}

@end
