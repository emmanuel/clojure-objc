//
//  CLJKeyword.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/23/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIFn.h"
#import "CLJNamed.h"
#import "CLJIHashEq.h"

@class CLJSymbol;


@interface CLJKeyword : NSObject <CLJIFn, CLJNamed, CLJIHashEq>

@property (nonatomic, readonly) CLJSymbol *sym;

+ (instancetype)keywordWithSymbol:(CLJSymbol *)symbol;
+ (instancetype)keywordWithNamespaceOrName:(NSString *)namespaceOrName;
+ (instancetype)keywordWithNamespace:(NSString *)namespace name:(NSString *)name;

- (instancetype)initWithSymbol:(CLJSymbol *)symbol;

@end

@interface CLJKeyword (NotImplemented) <NSCoding>

@end
