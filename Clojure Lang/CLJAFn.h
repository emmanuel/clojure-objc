//
//  CLJAFn.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIFn.h"

@interface CLJAFn : NSObject <CLJIFn>

- (id)call;
- (void)run;
- (id)applyTo:(id<CLJISeq>)argumentSeq;

@end
