//
//  CLJITransientMap.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJITransientAssociative.h"
#import "CLJCounted.h"
#import "CLJIPersistentMap.h"

@protocol CLJITransientMap <NSObject, CLJITransientAssociative, CLJCounted>

- (id<CLJITransientMap>)assocKey:(id)key withValue:(id)value;
- (id<CLJITransientMap>)without:(id)key;

- (id<CLJIPersistentMap>)persistent;

@end
