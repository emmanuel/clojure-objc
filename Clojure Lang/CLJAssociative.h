//
//  CLJAssociative.h
//  Clojure Lang
//
//  Copyright (c) 2013 Emmanuel Gomez.
//  Published under the Eclipse Public License
//

#import <Foundation/Foundation.h>
#import "CLJIPersistentCollection.h"
#import "CLJILookup.h"

@protocol CLJIMapEntry;


@protocol CLJAssociative <NSObject, CLJIPersistentCollection, CLJILookup>

- (BOOL)containsKey:(id)key;
- (id<CLJIMapEntry>)entryAt:(id)key;
- (id<CLJAssociative>)assocKey:(id)key withObject:(id)object;


@end
