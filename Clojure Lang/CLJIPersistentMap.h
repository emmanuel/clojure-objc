//
//  CLJIPersistentMap.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJAssociative.h"
#import "CLJCounted.h"


@protocol CLJIPersistentMap <NSFastEnumeration, CLJAssociative, CLJCounted>

- (id <CLJIPersistentMap>)assocKey:(id)key withValue:(id)value;

- (id <CLJIPersistentMap>)assocEx:(id)key, id val;

- (id <CLJIPersistentMap>)without:(id)key;

@end
