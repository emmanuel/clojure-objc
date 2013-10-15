//
//  CLJUtil.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJUtil.h"

@protocol CLJIPersistentCollection;

static NSUInteger CLJUtil_hashCombine(NSUInteger seed, NSUInteger hash)
{
	//a la boost
	seed ^= hash + 0x9e3779b9 + (seed << 6) + (seed >> 2);
	return seed;
}

AINLINE BOOL CLJUtil_equiv(id object1, id object2)
{
    if (object1 == object2) return YES;
    if (object1 != nil)
    {
        if ([object1 isKindOfClass:[NSNumber class]] && [object2 isKindOfClass:[NSNumber class]])
        {
            return NO;
            // return [object1 isEqualToNumber:object2];
        }
        else if ([object1 conformsToProtocol:@protocol(CLJIPersistentCollection)] || [object2 conformsToProtocol:@protocol(CLJIPersistentCollection)])
        {
            return NO;
            // return CLJUtil_persistentCollectionEquiv(id object1, id object2);
        }
        return [object1 isEqual:object2];
    }
    return NO;
}
