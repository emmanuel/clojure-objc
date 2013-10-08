//
//  NSArray+ArrayWithChanges.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/6/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ArrayWithChanges)

- (instancetype)arrayWithIndex:(NSUInteger)index setToObject:(id)object;
- (instancetype)arrayWithObject:(id)object atIndex:(NSUInteger)index;

- (instancetype)arrayByRemovingLastObject;

@end
