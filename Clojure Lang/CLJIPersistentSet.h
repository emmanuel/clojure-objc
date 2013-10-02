//
//  CLJIPersistentSet.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIPersistentCollection.h"
#import "CLJCounted.h"


@protocol CLJIPersistentSet <CLJIPersistentCollection, CLJCounted, NSObject>

- (id <CLJIPersistentSet>)disjoin:(id)key;

- (BOOL)contains:(id)object;

- (id)get:(id)key;
- (id)objectForKey:(id)key;

@end
