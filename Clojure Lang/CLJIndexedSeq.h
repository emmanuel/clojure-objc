//
//  CLJIndexedSeq.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJISeq.h"
#import "CLJSequential.h"
#import "CLJCounted.h"

@protocol CLJIndexedSeq <CLJISeq, CLJSequential, CLJCounted>

- (NSUInteger)index;

@end
