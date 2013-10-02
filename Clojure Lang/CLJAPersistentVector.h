//
//  CLJAPersistentVector.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJAFn.h"
#import "CLJIObj.h"
#import "CLJIPersistentVector.h"


@interface CLJAPersistentVector : CLJAFn <CLJIObj, CLJIPersistentVector, NSCoding>

@end
