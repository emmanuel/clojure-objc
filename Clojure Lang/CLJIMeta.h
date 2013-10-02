//
//  CLJIMeta.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLJIPersistentMap;


@protocol CLJIMeta

- (id <CLJIPersistentMap>)meta;

@end
