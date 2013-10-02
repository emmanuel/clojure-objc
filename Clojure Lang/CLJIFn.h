//
//  CLJIFn.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

@protocol CLJISeq;


@protocol CLJIFn

- (id)invoke;

- (id)invoke:(id)arg;

- (id)invokeWithArgs:(id)arg1, ... NS_REQUIRES_NIL_TERMINATION;

- (id)applyTo:(id <CLJISeq>)argumentSeq;

@end
