//
//  CLJBox.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/27/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJBox.h"

@implementation CLJBox

+ (instancetype)boxWithObject:(id)object
{
    return [[self alloc] initWithObject:object];
}

- (instancetype)initWithObject:(id)object
{
    if (self = [super init])
    {
        self.object = object;
    }

    return self;
}

@end
