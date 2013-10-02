//
//  CLJArraySeq.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJASeq.h"
#import "CLJIndexedSeq.h"

@interface CLJArraySeq : CLJASeq <CLJIndexedSeq>

@property (nonatomic, readonly, strong) NSArray *array;
@property (nonatomic, readonly) NSUInteger index;

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta array:(NSArray *)array;

@end
