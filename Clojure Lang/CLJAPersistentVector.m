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

#pragma clang diagnostic ignored "-Wprotocol"
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation CLJAPersistentVector

//+ (instancetype)empty
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

- (instancetype)empty
{
    return [[[self class] empty] withMeta:self.meta];
}

#pragma mark - NSCoding methods

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [self doesNotRecognizeSelector:_cmd];
//}

#pragma mark - CLJIPersistentVector methods

- (NSInteger)length
{
    return [self count];
}

//- (instancetype)assocN:(NSUInteger)i withObject:(id)object
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

//- (id<CLJIPersistentVector>)cons:(id)object
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}


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

//- (BOOL)containsKey:(id)key
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return NO;
//}

//- (id<CLJIMapEntry>)entryAt:(id)key
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return NO;
//}

#pragma mark - CLJILookup methods

- (id)get:(id)key
{
    if ([key respondsToSelector:@selector(unsignedIntegerValue)])
    {
        return [self nth:[key unsignedIntegerValue]];
    }
    else
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"key must be an integer" userInfo:@{ @"key": key, @"vector": self }];
    }
}

- (id)get:(id)key withDefault:(id)notFound
{
    return [self get:key] ?: notFound;
}

#pragma mark - CLJIndexed methods

//- (id)nth:(NSUInteger)index
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

- (id)nth:(NSUInteger)index withDefault:(id)notFound
{
    return [self nth:index] ?: notFound;
}

#pragma mark - CLJIObj methods

//- (instancetype)withMeta:(id<CLJIPersistentMap>)meta
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

#pragma mark - CLJIPersistentStack methods

//- (id)peek
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

//- (instancetype)pop
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

#pragma mark - CLJIEquiv methods

//- (BOOL)equiv:(id)object
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return NO;
//}

#pragma mark - CLJSeqable methods

//- (id<CLJISeq>)seq
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

#pragma mark - CLJReversible methods

//- (id<CLJISeq>)rseq
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}


@end
