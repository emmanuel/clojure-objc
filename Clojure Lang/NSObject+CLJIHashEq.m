//
//  NSObject+CLJIHashEq.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/12/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSObject+CLJIHashEq.h"

@implementation NSObject (CLJIHashEq)

- (NSUInteger)clj_hasheq
{
    return [self hash];
}

@end
