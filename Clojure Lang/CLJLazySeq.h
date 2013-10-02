//
//  CLJLazySeq.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJObj.h"
#import "CLJISeq.h"
#import "CLJSequential.h"
#import "CLJIHashEq.h"
#import "CLJIPending.h"

@interface CLJLazySeq : CLJObj <CLJISeq, CLJSequential, CLJIPending, CLJIHashEq>

@end
