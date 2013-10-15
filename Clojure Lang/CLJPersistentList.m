//
//  CLJPersistentList.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJPersistentList.h"

@interface CLJPersistentList()

@property (nonatomic, readwrite, strong) id first;
@property (nonatomic, readwrite, strong) id<CLJIPersistentList> rest;
@property (nonatomic, readwrite) NSUInteger count;

@end


@implementation CLJPersistentList

+ (CLJPersistentList *)empty
{
    static CLJPersistentList *empty = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        empty = [[self alloc] initWithFirst:nil];
    });

    return empty;
}

- initWithFirst:(id)first
{
    if (self = [super initWithMeta:nil])
    {
        self.first = first;
        self.rest = nil;
        self.count = 1;
    }

    return self;
}

- initWithMeta:(id<CLJIPersistentMap>)meta
         first:(id)first
          rest:(id<CLJIPersistentList>)rest
         count:(NSUInteger)count
{
    if (self = [super initWithMeta:meta])
    {
        self.first = first;
        self.rest = rest;
        self.count = count;
    }
    
    return self;
}

#pragma mark - CLJASeq methods

- (id<CLJIPersistentList>)pop
{
    if (self.rest == nil)
        return [[[self class] empty] withMeta:[self meta]];

    return [self rest];
}

#pragma mark - CLJISeq methods

- (id<CLJISeq>)next
{
    if (self.count == 1) return nil;

    return (id<CLJISeq>)self.rest;
}

- (CLJPersistentList *)cons:(id)object
{
    return [[[self class] alloc] initWithMeta:[self meta]
                                        first:object
                                         rest:self
                                        count:[self count] + 1];
}

- (id<CLJIPersistentCollection>)empty
{
    return [[[self class] empty] withMeta:[self meta]];
}


# pragma mark - CLJIObj methods

- (instancetype)withMeta:(id<CLJIPersistentMap>)meta
{
    if (meta != [self meta])
        return [[[self class] alloc] initWithMeta:meta
                                            first:[self first]
                                             rest:[self rest]
                                            count:[self count]];

    return self;
}

@end
