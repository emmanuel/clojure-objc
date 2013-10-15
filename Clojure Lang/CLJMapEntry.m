//
//  CLJMapEntry.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/15/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJMapEntry.h"

@interface CLJMapEntry ()

@property (nonatomic, strong, readwrite) id key;
@property (nonatomic, strong, readwrite) id object;

@end


@implementation CLJMapEntry

+ (instancetype)mapEntryWithKey:(id)key object:(id)object
{
    return [[self alloc] initWithKey:key object:object];
}

- (instancetype)initWithKey:(id)key object:(id)object
{
    if (self = [super init])
    {
        self.key = key;
        self.object = object;
    }

    return self;
}

@end
