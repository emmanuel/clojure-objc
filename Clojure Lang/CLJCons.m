//
//  CLJCons.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/20/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJCons.h"
#import "CLJISeq.h"
#import "CLJPersistentList.h"
#import "CLJRT.h"

@interface CLJCons ()

@property (nonatomic, strong) id first;
@property (nonatomic, strong) id<CLJISeq> more;

@end

@implementation CLJCons

#pragma mark - Factory methods

+ (instancetype)consWithMeta:(id<CLJIPersistentMap>)meta first:(id)first more:(id<CLJISeq>)more
{
    return [[self alloc] initWithMeta:meta first:first more:more];
}

+ (instancetype)consWithFirst:(id)first more:(id<CLJISeq>)more
{
    return [[self alloc] initWithMeta:nil first:first more:more];
}

#pragma mark - Initialization methods

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta first:(id)first more:(id<CLJISeq>)more
{
    self = [super withMeta:meta];

    if (self)
    {
        _first = first;
        _more = more;
    }

    return self;
}

- (instancetype)initWithFirst:(id)first more:(id<CLJISeq>)more
{
    return [self initWithMeta:nil first:first more:more];
}

- (instancetype)withMeta:(id<CLJIPersistentMap>)meta
{
    return [[self class] consWithMeta:meta first:_first more:_more];
}

#pragma mark - CLJISeq methods

- (id<CLJISeq>)more
{
    return _more ?: [CLJPersistentList empty];
}

- (id<CLJISeq>)next
{
    return [_more seq];
}

- (NSUInteger)count
{
    return 1 + [_more count];
}

@end

//final public class Cons extends ASeq implements Serializable {
//    
//    private final Object _first;
//    private final ISeq _more;
//    
//    public int count(){
//        return 1 + RT.count(_more);
//    }
//}
