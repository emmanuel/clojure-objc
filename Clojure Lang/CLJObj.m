//
//  CLJObj.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJObj.h"

@implementation CLJObj

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta
{
    if (self = [super init])
    {
        _meta = meta;
    }

    return self;
}

@end
