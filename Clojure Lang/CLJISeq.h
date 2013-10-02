//
//  CLJISeq.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJIPersistentCollection.h"

@protocol CLJISeq <CLJIPersistentCollection>

- (id)first;
- (id<CLJISeq>)next;
- (id<CLJISeq>)more;
- (id<CLJISeq>)cons:(id)object;

@end
