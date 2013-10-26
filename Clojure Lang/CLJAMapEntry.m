//
//  CLJAMapEntry.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/15/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAMapEntry.h"

// This is an abstract class, so ignore not implemented warnings
#pragma clang diagnostic ignored "-Wprotocol"

@implementation CLJAMapEntry

#pragma mark - CLJIMapEntry methods

#pragma mark - CLJIPersistentVector methods

- (id)nth:(NSUInteger)index
{
    if (0 == index) return self.key;
    if (1 == index) return self.object;
    @throw [NSException exceptionWithName:NSRangeException reason:@"map entries have 2 elements" userInfo:nil];
}

#pragma mark - CLJCounted methods

- (NSUInteger)count
{
    return 2;
}

@end
