//
//  CLJASeq.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJSeqable.h"
#import "CLJASeq.h"
#import "CLJPersistentList.h"
#import "CLJRT.h"
#import "CLJUtil.h"

@protocol CLJCounted;


@interface CLJASeq ()

@property (nonatomic, getter = clj_hasheq) NSUInteger hasheq;

@end

#pragma clang diagnostic ignored "-Wprotocol"

@implementation CLJASeq
{
    NSUInteger _hash;
}

#pragma mark - Initialization methods

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta
{
    if (self = [super initWithMeta:meta])
    {
        _hash = kCLJIHashEqUninitializedHashValue;
    }

    return self;
}

#pragma mark - NSObject methods

- (NSString *)description
{
//	return RT.printString(this);
    return [super description];
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    else if (!([object conformsToProtocol:@protocol(CLJSequential)] || [object isKindOfClass:[NSArray class]]))
    {
        return NO;
    }

    id<CLJISeq> ms = [object seq];
    for (id<CLJISeq> s = [self seq]; nil != s; s = [s next], ms = [ms next]) {
        if (nil == ms) // || CLJUtil_equal([s first], [ms first]))
        {
            return NO;
        }
    }

    return nil == ms;
}

- (NSUInteger)hash
{
    if (kCLJIHashEqUninitializedHashValue == _hash)
    {
        NSUInteger hash = 1;
        for (id<CLJISeq> s = [self seq]; nil != s; s = [s next]) {
            hash = 31 * hash + ([[s first] hash] || 0);
        }
        _hash = hash;
    }

    return _hash;
}

#pragma mark - CLJIPersistentCollection methods

- (id<CLJIPersistentCollection>)empty
{
    return [CLJPersistentList empty];
}

//- (id<CLJISeq>)cons:(id)object
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

#pragma mark - CLJASeq methods

//- (id)first
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

//- (id<CLJISeq>)next
//{
//    [self doesNotRecognizeSelector:_cmd];
//    return nil;
//}

- (id<CLJISeq>)rest
{
    return [[self more] seq];
}

#pragma mark - CLJIEquiv methods

- (BOOL)equiv:(id)object
{
    if (!([object conformsToProtocol:@protocol(CLJSequential)] || [object isKindOfClass:[NSArray class]]))
    {
		return false;
    }

	id<CLJISeq> ms = [object seq];
	for(id<CLJISeq> s = [self seq]; s != nil; s = [s next], ms = [ms next])
    {
		if (nil == ms) // || !CLJUtil_equiv([s first], [ms first]))
        {
			return false;
        }
    }

	return ms == nil;
}

#pragma mark - CLJIHashEq methods

- (NSUInteger)clj_hasheq
{
    if (kCLJIHashEqUninitializedHashValue == _hasheq)
    {
        NSUInteger hash = 1;
        for (id<CLJISeq> s = [self seq]; nil != s; s = [s next])
        {
            hash = 31 * hash + [[s first] clj_hasheq];
        }
        self.hasheq = hash;
    }

    return _hasheq;
}

- (id)peek
{
    return [self first];
}

#pragma mark - CLJCounted methods

- (NSUInteger)count
{
    NSUInteger i = 1;

    for (id<CLJISeq> s = [self next]; nil != s; s = [s next], i++) {
        if ([s conformsToProtocol:@protocol(CLJCounted)]) return i + [s count];
    }

    return i;
}

#pragma mark - CLJSeqable methods

- (id<CLJISeq>)seq
{
    return self;
}

#pragma mark - CLJISeq methods

- (id<CLJISeq>)more
{
    id<CLJISeq> s = [self next];
    if (nil == s) return [CLJPersistentList empty];
    return s;
}

@end
