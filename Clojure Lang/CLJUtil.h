//
//  CLJUtil.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

AINLINE NSUInteger CLJUtil_hash(id obj);
AINLINE NSUInteger CLJUtil_hasheq(id obj);

AINLINE NSUInteger CLJUtil_hashCombine(NSUInteger seed, NSUInteger hash);

AINLINE BOOL CLJUtil_equal(id obj1, id obj2);

AINLINE BOOL CLJUtil_equiv(id obj1, id obj2);

