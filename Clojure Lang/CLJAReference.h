//
//  CLJAReference.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/17/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIReference.h"


@interface CLJAReference : NSObject <CLJIReference>

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta;

@end
