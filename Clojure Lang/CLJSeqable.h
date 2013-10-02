//
//  CLJSeqable.h
//  Clojure Lang
//
//  Copyright (c) 2013 Emmanuel Gomez.
//  Published under the Eclipse Public License
//

@protocol CLJISeq;
@protocol CLJSeqable;
#import "NSArray+CLJSeqable.h"
#import "NSEnumerator+CLJSeqable.h"


@protocol CLJSeqable <NSObject>

- (id <CLJISeq>)seq;

@end
