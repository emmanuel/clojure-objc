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


@implementation CLJAPersistentMap

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

- (NSUInteger)hash
{
    if (_hash == kCLJIHashEqUninitializedHashValue)
        _hash = [[self class] mapHashForMap:self];

    return _hash;
}

#pragma mark - CLJIPersistentCollection methods

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

@end
