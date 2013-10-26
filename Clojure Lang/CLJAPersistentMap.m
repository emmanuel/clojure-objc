//
//  CLJAPersistentMap.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/NSException.h>
#import "CLJAPersistentMap.h"
#import "CLJISeq.h"
#import "CLJIMapEntry.h"
#import "CLJIPersistentVector.h"


@interface CLJAPersistentMap ()
{
    NSUInteger _hash;
}

@property (nonatomic, getter = clj_hasheq) NSUInteger hasheq;

@end


#pragma clang diagnostic ignored "-Wprotocol"


@implementation CLJAPersistentMap

#pragma mark - Factory methods

+ (NSUInteger)mapHashForMap:(CLJAPersistentMap *)map
{
    NSUInteger hash = kCLJIHashEqUninitializedHashValue;

    for(id<CLJISeq> s = [map seq]; s != nil; s = [s next])
    {
        id<CLJIMapEntry> e = (id<CLJIMapEntry>)[s first];
        hash += ([e key] == nil ? 0 : [[e key] hash]) ^
            ([e object] == nil ? 0 : [[e object] hash]);
    }

	return hash;
}

#pragma mark - NSObject methods

- (NSUInteger)hash
{
    if (_hash == kCLJIHashEqUninitializedHashValue)
        _hash = [[self class] mapHashForMap:self];

    return _hash;
}

#pragma mark - CLJIPersistentMap methods

//- (instancetype)assocEx:(id)key withObject:(id)object
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

//- (instancetype)without:(id)key
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

#pragma mark - CLJIPersistentCollection methods

//- (id<CLJIPersistentCollection>)empty
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

- (id<CLJIPersistentCollection>)cons:(id)object
{
    if ([object conformsToProtocol:@protocol(CLJIMapEntry)])
    {
        id<CLJIMapEntry> mapEntry = (id<CLJIMapEntry>)object;
        return [self assocKey:[mapEntry key] withObject:[mapEntry object]];
    }
    else if ([object conformsToProtocol:@protocol(CLJIPersistentVector)])
    {
        id<CLJIPersistentVector> vector = (id<CLJIPersistentVector>)object;
        if (2 != [vector count])
        {
            @throw [NSException exceptionWithName:NSInvalidArgumentException
                                           reason:@"Vector arg to map conj must be a pair"
                                         userInfo:nil];
        }
        
        return [self assocKey:[vector nth:0] withObject:[vector nth:1]];
    }
    
    id<CLJIPersistentMap> returnValue = self;
    
    for (id<CLJISeq> es = [object seq]; es != nil; es = [es next]) {
        id<CLJIMapEntry> mapEntry = (id<CLJIMapEntry>)[es first];
        returnValue = [returnValue assocKey:[mapEntry key] withObject:[mapEntry object]];
    }
    
    return returnValue;
}

#pragma mark - CLJAssociative methods

//- (id)get:(id)key
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

- (id)get:(id)key withDefault:(id)notFound
{
    return [self get:key] ?: notFound;
}

#pragma mark - CLJAssociative methods

//- (instancetype)assocKey:(id)key withObject:(id)object
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

//- (id<CLJIMapEntry>)entryAt:(id)key
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

//- (BOOL)containsKey:(id)key
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return NO;
//}

#pragma mark - CLJIEquiv methods

//- (BOOL)equiv:(id)object
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return NO;
//}

#pragma mark - CLJISeqable methods

//- (id<CLJISeq>)seq
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

@end
