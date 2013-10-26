//
//  CLJPersistentHashMapUtils.c
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/10/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJPersistentHashMapUtils.h"
#import "CLJIHashEq.h"



AINLINE NSUInteger CLJPersistentHashMapUtil_mask(NSUInteger hash, NSUInteger shift)
{
	return ((hash >> shift) & 0x01f);
}

AINLINE NSUInteger CLJPersistentHashMapUtil_bitPosition(NSUInteger hash, NSUInteger shift)
{
    return 1 << CLJPersistentHashMapUtil_mask(hash, shift);
}

AINLINE NSUInteger CLJPersistentHashMapUtil_bitRank(NSUInteger bitmap, NSUInteger bit)
{
    return CLJPersistentHashMapUtil_bitPopulation(bitmap & (bit - 1));
}

// http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetKernighan
AINLINE NSUInteger CLJPersistentHashMapUtil_bitPopulation(NSUInteger bitmap)
{
    NSUInteger count;
    for (count = 0; bitmap; count++) {
        bitmap &= bitmap - 1;
    }
    return count;
}
