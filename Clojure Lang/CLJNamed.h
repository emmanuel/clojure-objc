//
//  CLJNamed.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLJNamed

@property (nonatomic, readonly) NSString *namespace;
@property (nonatomic, readonly) NSString *name;

@end
