//
//  CLJIPersistentMap.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAssociative.h"
#import "CLJCounted.h"

// TODO: NSFastEnumeration
@protocol CLJIPersistentMap <CLJAssociative, CLJCounted>

- (id<CLJIPersistentMap>)assocKey:(id)key withObject:(id)object;
- (id<CLJIPersistentMap>)assocEx:(id)key withObject:(id)object;
- (id<CLJIPersistentMap>)without:(id)key;

@end
