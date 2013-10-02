//
//  Sequential.h
//  Clojure Lang
//
//  Copyright (c) 2013 Emmanuel Gomez.
//  Published under the Eclipse Public License
//

#import <objc/runtime.h>
#import "CLJRT.h"

@protocol CLJSequential

@optional

- (id)nth:(NSUInteger)index;
- (id)nth:(NSUInteger)index withDefault:(id)notFound;

@end

// Provide default implementations of available methods for conforming classes
@interface CLJSequential : NSObject <CLJSequential>

+ (void)addDefaultImplementationForClass:(Class)conformingClass;

@end
