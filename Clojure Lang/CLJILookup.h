//
//  CLJILookup.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

@protocol CLJILookup;
#import "NSDictionary+CLJILookup.h"

@protocol CLJILookup

- (id)get:(id)key;
- (id)get:(id)key withDefault:(id)notFound;

@end
