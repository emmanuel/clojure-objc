//
//  CLJAPersistentVector.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAPersistentVector.h"

@interface CLJAPersistentVector ()
{
    NSInteger _hash;
    NSInteger _hasheq;
}

@end

@implementation CLJAPersistentVector

#pragma mark - CLJIPersistentVector methods

- (NSInteger)length
{
    return [self count];
}

- (instancetype)assocN:(NSUInteger)i withObject:(id)object
{
    return nil;
}

- (id<CLJIPersistentVector>)cons:(id)object
{
    return nil;
}


#pragma mark - CLJAssociative methods

- (id<CLJAssociative>)assocKey:(id)key withValue:(id)val
{
    if ([key respondsToSelector:@selector(integerValue)])
    {
        return [self assocN:[key integerValue] withObject:val];
    }
    else
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"key must be an integer" userInfo:@{ @"key": key, @"val": val, @"vector": self }];
    }
}

#pragma mark - CLJILookup methods

- (id)get:(id)key
{
    return [self nth:[key integerValue]];
}

- (id)get:(id)key withDefault:(id)notFound
{
    return [self get:key] ?: notFound;
}

#pragma mark - CLJIndexed methods

- (id)nth:(NSInteger)index withDefault:(id)notFound
{
    return [self nth:index] ?: notFound;
}

#pragma mark - CLJIndexed methods



@end
