//
//  CLJEnumeratorSeq.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/22/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJASeq.h"

@interface CLJEnumeratorSeq : CLJASeq

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta enumerator:(NSEnumerator *)enumerator;

@end
