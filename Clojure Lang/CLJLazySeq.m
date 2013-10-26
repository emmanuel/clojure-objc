//
//  CLJLazySeq.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJLazySeq.h"
#import "CLJIFn.h"
#import "CLJISeq.h"

@interface CLJLazySeq ()

@property (nonatomic, strong) id<CLJIFn> fn;
@property (nonatomic, strong) id<CLJISeq> seq;

@end

#pragma clang diagnostic ignored "-Wprotocol"


@implementation CLJLazySeq
{
//    id sv;
}

#pragma mark - Initialization methods
- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta sequence:(id<CLJISeq>)seq
{
    if (self = [super initWithMeta:meta])
    {
        self.seq = seq;
    }

    return self;
}

#pragma mark - CLJCounted methods

- (NSUInteger)count
{
    NSUInteger count = 0;

	for (id<CLJISeq> s = [self seq]; s != nil; s = [s next])
        ++count;

    return count;
}

//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    if ((@selector(first) == aSelector) || (@selector(next) == aSelector) || ())
//    {
//        
//    }
//    else if ([@protocol(CLJISeq) ])
//    {
//        
//    }
//}

#pragma mark - CLJISeq methods

- (id)first
{
    return [[self seq] first];
}

- (id<CLJISeq>)next
{
    return [[self seq] next];
}

- (id<CLJISeq>)more
{
    return [[self seq] more];
}

@end
