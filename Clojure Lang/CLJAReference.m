//
//  CLJAReference.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/17/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAReference.h"
#import "CLJIFn.h"
#import "CLJCons.h"


@interface CLJAReference ()

@property (nonatomic, readwrite, strong) id<CLJIPersistentMap> meta;

@end


@implementation CLJAReference

#pragma mark - Initialization methods

#pragma mark Designated initializer

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta
{
    if (self = [super init])
    {
        _meta = meta;
    }

    return self;
}

#pragma mark - CLJIReference methods

- (id<CLJIPersistentMap>)alterMeta:(id<CLJIFn>)alterFn withSeq:(id<CLJISeq>)seq
{
    @synchronized(self)
    {
        // TODO: pick this up:
        _meta = [alterFn applyTo:[[CLJCons alloc] init]];
        return _meta;
    }
}

- (id<CLJIPersistentMap>)resetMeta:(id<CLJIPersistentMap>)meta
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
