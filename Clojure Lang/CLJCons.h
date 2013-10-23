//
//  CLJCons.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/20/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJASeq.h"

@interface CLJCons : CLJASeq // <NSCoding>

+ (instancetype)consWithMeta:(id<CLJIPersistentMap>)meta first:(id)first more:(id<CLJISeq>)more;
+ (instancetype)consWithFirst:(id)first more:(id<CLJISeq>)more;

@end
