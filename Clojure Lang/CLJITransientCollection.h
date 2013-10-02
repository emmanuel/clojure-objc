//
//  CLJITransientCollection.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIPersistentCollection.h"

@protocol CLJITransientCollection <NSObject>

- (id<CLJITransientCollection>)conj:(id)val;

- (id<CLJIPersistentCollection>)persistent;

@end
