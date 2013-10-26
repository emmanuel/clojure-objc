//
//  NSArray+CLJSeqable.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/23/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSArray+CLJSeqable.h"
#import "CLJArraySeq.h"

@implementation NSArray (CLJSeqable)

- (id<CLJISeq>)seq
{
    return [[CLJArraySeq alloc] initWithMeta:nil array:self index:0];
}

@end
