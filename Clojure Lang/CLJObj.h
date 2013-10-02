//
//  CLJObj.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIObj.h"

@protocol CLJIPersistentMap;

@interface CLJObj : NSObject <CLJIObj, NSCoding>

@property (nonatomic, readonly, retain) id<CLJIPersistentMap> meta;

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta;

@end
