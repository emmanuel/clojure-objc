//
//  CLJUtil.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJUtil.h"

static NSUInteger CLJUtil_hashCombine(NSUInteger seed, NSUInteger hash)
{
	//a la boost
	seed ^= hash + 0x9e3779b9 + (seed << 6) + (seed >> 2);
	return seed;
}
