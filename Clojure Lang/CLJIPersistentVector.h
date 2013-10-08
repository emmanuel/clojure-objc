//
//  CLJIPersistentVector.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJAssociative.h"
#import "CLJSequential.h"
#import "CLJIPersistentStack.h"
#import "CLJReversible.h"
#import "CLJIndexed.h"


@protocol CLJIPersistentVector <NSObject, CLJAssociative, CLJSequential, CLJIPersistentStack, CLJReversible, CLJIndexed>

- (NSInteger)length;
- (id<CLJIPersistentVector>)assocN:(NSUInteger)index withObject:(id)object;
- (id<CLJIPersistentVector>)cons:(id)object;

@end
