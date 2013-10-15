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


static inline NSUInteger CLJPersistentHashMapUtil_hash(id object);

static inline NSUInteger CLJPersistentHashMapUtil_mask(NSUInteger hash, NSUInteger shift);

static inline NSUInteger CLJPersistentHashMapUtil_bitpos(NSUInteger hash, NSUInteger shift);

static inline NSUInteger CLJPersistentHashMapUtil_bitRank(NSUInteger bitmap, NSUInteger bit);
static inline NSUInteger CLJPersistentHashMapUtil_countBitPopulation(NSUInteger bits);

static CFTypeRef * const CLJPersistentHashMapArrayNode_cloneAndSet(CFTypeRef *sourceArray, NSUInteger index, id object);

static CFTypeRef * const CLJPersistentHashMapArrayNode_makeNilFilledArray();

static CFTypeRef * const CLJPersistentHashMapArrayNode_makeFullSizeNilFilledArray();

#endif
