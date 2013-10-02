//
//  CLJRT.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

@protocol CLJISeq;
@protocol CLJIPersistentMap;


static inline id CLJRT_readTrueFalseUnknown(NSString *s);

static inline id<CLJIPersistentMap> CLJRT_meta(id object);

static inline void CLJRT_addDefaultImplementationForClassOfProtocolFromImplementingClass(Class conformingClass, Protocol *, Class implementingClass);
