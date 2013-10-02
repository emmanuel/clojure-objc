//
//  CLJIPersistentList.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJSequential.h"
#import "CLJIPersistentStack.h"

@protocol CLJIPersistentList <NSObject, CLJSequential, CLJIPersistentStack>

@end
