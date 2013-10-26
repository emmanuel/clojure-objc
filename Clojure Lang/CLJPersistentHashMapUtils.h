//
//  CLJPersistentHashMapUtils.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/10/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJPersistentHashMapConstants.h"


@protocol CLJIPersistentHashMapNode;

#if __has_attribute(always_inline)
#define ALWAYS_INLINE __attribute__((always_inline))
#else
#define ALWAYS_INLINE static inline
#endif

#ifndef Clojure_Lang_CLJPersistentHashMapUtils_h
#define Clojure_Lang_CLJPersistentHashMapUtils_h


AINLINE NSUInteger CLJPersistentHashMapUtil_mask(NSUInteger hash, NSUInteger shift);

AINLINE NSUInteger CLJPersistentHashMapUtil_bitPosition(NSUInteger hash, NSUInteger shift);

AINLINE NSUInteger CLJPersistentHashMapUtil_bitRank(NSUInteger bitmap, NSUInteger bit);
AINLINE NSUInteger CLJPersistentHashMapUtil_bitPopulation(NSUInteger bits);

#endif
