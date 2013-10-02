//
//  CLJArraySeq.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJArraySeq.h"

@implementation CLJArraySeq

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta
                       array:(NSArray *)anArray
                       index:(NSUInteger)anIndex
{
    self = [super initWithMeta:meta];
    if (self)
    {
        _array = [anArray copy];
        _index = anIndex;
    }

    return self;
}



@end
