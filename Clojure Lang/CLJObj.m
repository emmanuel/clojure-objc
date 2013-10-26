//
//  CLJObj.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJObj.h"

@implementation CLJObj

#pragma mark - Initialization methods

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta
{
    if (self = [super init])
    {
        _meta = meta;
    }

    return self;
}

#pragma mark - Initialization methods

- (instancetype)withMeta:(id<CLJIPersistentMap>)meta
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
