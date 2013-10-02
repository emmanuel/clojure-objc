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

#pragma mark - Initialization methods

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta first:(id)first more:(id<CLJISeq>)more
{
    self = [super withMeta:meta];

    if (self)
    {
        self.first = first;
        self.more = more;
    }

    return self;
}

- (instancetype)initWithFirst:(id)first more:(id<CLJISeq>)more
{
    self = [super withMeta:nil];

    if (self)
    {
        self.first = first;
        self.more = more;
    }

    return self;
}

- (instancetype)withMeta:(id<CLJIPersistentMap>)meta
{
    return [[CLJCons alloc] initWithMeta:meta first:self.first more:self.more];
}

#pragma mark - CLJISeq methods

- (id<CLJISeq>)more
{
    return _more ?: [CLJPersistentList empty];
}

- (id<CLJISeq>)next
{
    return [[self more] seq];
}

#pragma mark - CLJCounted methods

- (NSUInteger)count
{
    return 1 + [self.more count];
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
