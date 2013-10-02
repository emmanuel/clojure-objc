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

@property (nonatomic, readonly) NSString *namespace;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly, retain) id <CLJIPersistentMap> meta;

+ (instancetype)symbolWithNamespace:(NSString *)namespace name:(NSString *)name;
+ (instancetype)symbolWithNamespaceOrName:(NSString *)namespaceOrName;

@end
