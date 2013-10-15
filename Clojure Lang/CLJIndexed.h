//
//  CLJIndexed.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJCounted.h"


@protocol CLJIndexed <NSObject, CLJCounted>

- (id)nth:(NSUInteger)index;
- (id)nth:(NSUInteger)index withDefault:(id)notFound;

@end
