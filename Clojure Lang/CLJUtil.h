//
//  CLJUtil.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

static inline NSUInteger CLJUtil_hash(id obj);
static inline NSUInteger CLJUtil_hasheq(id obj);

static inline NSUInteger CLJUtil_hashCombine(NSUInteger seed, NSUInteger hash);

static inline BOOL CLJUtil_equal(id obj1, id obj2);

static inline BOOL CLJUtil_equiv(id obj1, id obj2);

