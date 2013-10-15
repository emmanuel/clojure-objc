//
//  CLJMapEntry.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/15/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAMapEntry.h"

@interface CLJMapEntry : CLJAMapEntry

@property (nonatomic, strong, readonly) id key;
@property (nonatomic, strong, readonly) id object;

+ (instancetype)mapEntryWithKey:(id)key object:(id)object;

@end
