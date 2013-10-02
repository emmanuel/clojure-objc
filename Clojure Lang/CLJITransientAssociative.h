//
//  CLJITransientAssociative.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJITransientCollection.h"
#import "CLJILookup.h"

@protocol CLJITransientAssociative <NSObject, CLJITransientCollection, CLJILookup>

- (id<CLJITransientAssociative>)assocKey:(id)key withValue:(id)value;

@end
