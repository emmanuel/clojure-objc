//
//  CLJIReference.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/23/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIMeta.h"

@protocol CLJIPersistentMap;
@protocol CLJIFn;
@protocol CLJISeq;


@protocol CLJIReference <NSObject, CLJIMeta>

- (id<CLJIPersistentMap>)alterMeta:(id<CLJIFn>)alterFn withSeq:(id<CLJISeq>)seq;
- (id<CLJIPersistentMap>)resetMeta:(id<CLJIPersistentMap>)meta;

@end
