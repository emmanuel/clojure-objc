//
//  CLJAMapEntry.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/15/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAMapEntry.h"

@implementation CLJAMapEntry

- (id)nth:(NSUInteger)index
{
    if (0 == index) return self.key;
    if (1 == index) return self.object;
    @throw [NSException exceptionWithName:NSRangeException reason:@"map entries have 2 elements" userInfo:nil];
}

- (NSUInteger)count
{
    return 2;
}

@end
