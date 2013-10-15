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
}

/// CLJIMeta
@property (nonatomic) id<CLJIPersistentMap> meta;
/// CLJIHashEq
@property (nonatomic, getter = clj_hasheq) NSUInteger hasheq;

@end

@implementation CLJAPersistentVector

- (id<CLJIPersistentMap>)empty
{
    return [[[self class] empty] withMeta:self.meta];
}

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

- (id<CLJAssociative>)assocKey:(id)key withObject:(id)val
{
    if ([key respondsToSelector:@selector(unsignedIntegerValue)])
    {
        return [self assocN:[key unsignedIntegerValue] withObject:val];
    }
    else
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"key must be an integer" userInfo:@{ @"key": key, @"val": val, @"vector": self }];
    }
}

#pragma mark - CLJILookup methods

- (id)get:(id)key
{
    return [self nth:[key unsignedIntegerValue]];
}

- (id)get:(id)key withDefault:(id)notFound
{
    return [self get:key] ?: notFound;
}

#pragma mark - CLJIndexed methods

- (id)nth:(NSUInteger)index withDefault:(id)notFound
{
    return [self nth:index] ?: notFound;
}

#pragma mark - CLJIndexed methods



@end
