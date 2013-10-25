//
//  CLJAPersistentMap.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAFn.h"
#import "CLJIPersistentMap.h"
#import "CLJIHashEq.h"


// TODO: conform to and implement NSFastEnumeration
// TODO: conform to and implement NSCoding
@interface CLJAPersistentMap : CLJAFn <CLJIPersistentMap, CLJIHashEq>

- (instancetype)assocKey:(id)key withObject:(id)object;
- (instancetype)assocEx:(id)key withObject:(id)object;
- (instancetype)without:(id)key;

@end
