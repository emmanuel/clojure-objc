//
//  CLJNamed.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLJNamed

@property (nonatomic, strong, readonly) NSString *ns;
@property (nonatomic, strong, readonly) NSString *name;

@end
