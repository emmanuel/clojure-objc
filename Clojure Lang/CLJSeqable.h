//
//  CLJSeqable.h
//  Clojure Lang
//
//  Copyright (c) 2013 Emmanuel Gomez.
//  Published under the Eclipse Public License
//

#import <Foundation/Foundation.h>

@protocol CLJISeq;


@protocol CLJSeqable <NSObject>

- (id<CLJISeq>)seq;

@end
