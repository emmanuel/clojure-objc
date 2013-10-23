//
//  NSString+CLJIntern.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/16/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "NSString+CLJIntern.h"

@implementation NSString (CLJIntern)

- (NSString *)clj_intern
{
    static NSMutableDictionary *internPool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        internPool = [NSMutableDictionary dictionary];
    });

    NSString *immutableSelf = [NSString stringWithString:self];
    NSString *interned = internPool[immutableSelf];
    if (nil == interned) internPool[immutableSelf] = immutableSelf;
    return interned ?: immutableSelf;
}

@end
