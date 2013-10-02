//
//  CLJPersistentHashMapUtils.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJPersistentHashMapUtil.h"

static inline NSInteger CLJPersistentHashMapUtil_mask(NSInteger hash, NSInteger shift)
{
	return ((hash >> shift) & 0x01f);
}

static inline NSInteger CLJPersistentHashMapUtil_bitpos(NSInteger hash, NSInteger shift)
{
    return 1 << CLJPersistentHashMapUtil_mask(hash, shift);
}
