//
//  CLJAtomicReference.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/16/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLJAtomicReference : NSObject

@property (atomic, strong) id object;
@property (atomic, strong) Class type;

@end
