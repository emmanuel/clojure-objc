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

@implementation CLJASeq
{
    NSUInteger _hash;
    NSUInteger _hasheq;
}

#pragma mark - Initialization methods

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta
{
    if (self = [super initWithMeta:meta])
    {
        _hash = -1;
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
        if (nil == ms || CLJUtil_equal([s first], [ms first]))
        {
            return NO;
        }
    }

    return nil == ms;
}

- (NSUInteger)hash
{
    if (-1 == _hash)
    {
        NSUInteger hash = 1;
        for (id<CLJISeq> s = [self seq]; nil != s; s = [s next]) {
            hash = 31 * hash + ([[s first] hash] || 0);
        }
        _hash = hash;
    }

    return _hash;
}

#pragma mark - CLJASeq methods

- (id<CLJIPersistentCollection>)empty
{
    return [CLJPersistentList empty];
}

- (id<CLJISeq>)rest
{
    id<CLJSeqable> m = [self more];
    
    if (nil == m) return nil;
    
    return [m seq];
}

#pragma mark - equiv

- (BOOL)equiv:(id)object
{
    if (!([object conformsToProtocol:@protocol(CLJSequential)] || [object isKindOfClass:[NSArray class]]))
    {
		return false;
    }

	id<CLJISeq> ms = [object seq];
	for(id<CLJISeq> s = [self seq]; s != nil; s = [s next], ms = [ms next])
    {
		if (nil == ms || !CLJUtil_equiv([s first], [ms first]))
        {
			return false;
        }
    }

	return ms == nil;
}

#pragma mark - CLJIHashEq methods

- (NSUInteger)hasheq
{
    if (-1 == _hasheq)
    {
        NSUInteger hash = 1;
        for (id<CLJISeq> s = [self seq]; nil != s; s = [s next]) {
            hash = 31 * hash + CLJUtil_hasheq([s first]);
        }
        _hasheq = hash;
    }

    return _hasheq;
}

- (id)peek
{
    return [self first];
}

- (instancetype)pop
{
    return [self rest];
}

#pragma mark - CLJCounted methods

- (NSUInteger)count
{
    NSUInteger i = 1;

    for (id<CLJISeq> s = [self next]; nil != s; s = [s next], i++) {
        if ([((id) s) conformsToProtocol:@protocol(CLJCounted)])
        {
            return i + [s count];
        }
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

//
////public Object reduce(IFn f) {
////	Object ret = first();
////	for(ISeq s = rest(); s != null; s = s.rest())
////		ret = f.invoke(ret, s.first());
////	return ret;
////}
////
////public Object reduce(IFn f, Object start) {
////	Object ret = f.invoke(start, first());
////	for(ISeq s = rest(); s != null; s = s.rest())
////		ret = f.invoke(ret, s.first());
////	return ret;
////}
//
////
//public ISeq cons(Object o){
//	return new Cons(o, this);
//}
