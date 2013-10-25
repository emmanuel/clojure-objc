//
//  CLJIPersistentCollection.h
//  Clojure Lang
//
//  Copyright (c) 2013 Emmanuel Gomez.
//  Published under the Eclipse Public License
//

#import "CLJSeqable.h"

@protocol CLJIPersistentCollection <CLJSeqable>

- (id<CLJIPersistentCollection>)cons:(id)object;
- (id<CLJIPersistentCollection>)empty;
- (BOOL)equiv:(id)object;

@optional

- (NSUInteger)count;

@end


@interface CLJIPersistentCollection : NSObject <CLJIPersistentCollection>

+ (void)addDefaultImplementationForClass:(Class)conformingClass;

@end
