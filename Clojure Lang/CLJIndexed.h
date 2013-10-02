//
//  CLJIndexed.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJCounted.h"
@protocol CLJIndexed;
#import "NSArray+CLJIndexed.h"
#import "NSString+CLJIndexed.h"


@protocol CLJIndexed <NSObject, CLJCounted>

- (id)nth:(NSInteger)index;
- (id)nth:(NSInteger)index withDefault:(id)notFound;

@end
