//
//  CLJRT.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

@protocol CLJISeq;
@protocol CLJIPersistentMap;


AINLINE id CLJRT_readTrueFalseUnknown(NSString *s);

AINLINE id<CLJIPersistentMap> CLJRT_meta(id object);

AINLINE void CLJRT_addDefaultImplementationForClassOfProtocolFromImplementingClass(Class conformingClass, Protocol *proto, Class implementingClass);
