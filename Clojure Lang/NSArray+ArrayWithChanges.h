//
//  NSArray+ArrayWithChanges.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/6/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ArrayWithChanges)

- (NSArray *)arrayWithIndex:(NSUInteger)index setToObject:(id)object;
- (NSArray *)arrayWithObject:(id)object atIndex:(NSUInteger)index;

@end
