//
//  CLJBox.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/27/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLJBox : NSObject

@property (nonatomic, weak) id object;


+ (instancetype)boxWithObject:(id)object;

- (instancetype)initWithObject:(id)object;

@end
