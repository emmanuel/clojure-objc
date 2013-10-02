//
//  NSEnumerator+CLJSeqable.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/23/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSEnumerator+CLJSeqable.h"
#import "CLJEnumeratorSeq.h"

@implementation NSEnumerator (CLJSeqable)

- (id<CLJISeq>)seq
{
    return [[CLJEnumeratorSeq alloc] initWithMeta:nil enumerator:self];
}

@end
