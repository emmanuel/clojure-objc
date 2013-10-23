//
//  CLJSymbol.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAFn.h"
#import "CLJIObj.h"
#import "CLJNamed.h"
#import "CLJIHashEq.h"

@protocol CLJIPersistentMap;


@interface CLJSymbol : CLJAFn <CLJIObj, CLJNamed, CLJIHashEq>

+ (instancetype)symbolWithNamespaceOrName:(NSString *)nsOrName;
+ (instancetype)symbolWithNamespace:(NSString *)ns name:(NSString *)name;

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta namespace:(NSString *)nsInterned name:(NSString *)nameInterned;

@end
