//
//  CLJReversible.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/27/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJISeq.h"

@protocol CLJReversible <NSObject>

- (id<CLJISeq>)rseq;

@end
