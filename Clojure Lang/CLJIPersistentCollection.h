//
//  CLJIPersistentCollection.h
//  Clojure Lang
//
//  Copyright (c) 2013 Emmanuel Gomez.
//  Published under the Eclipse Public License
//

#import <Foundation/Foundation.h>
#import "CLJISeq.h"
#import "CLJSeqable.h"

@protocol CLJIPersistentCollection <CLJSeqable, NSObject>

- (id <CLJIPersistentCollection>)cons:(id)object;

- (id <CLJIPersistentCollection>)empty;

- (BOOL)equiv:(id)object;


@optional

- (NSUInteger)count;

@end


@interface CLJIPersistentCollection : NSObject <CLJIPersistentCollection>

@end


@implementation CLJIPersistentCollection

- (NSUInteger)count
{
    id<CLJISeq> seq = [self seq];
    int i = 0;
    // TODO: add NSFastEnumeration support to CLJISeq
    for(; nil != seq; seq = [seq next]) {
        if ([seq respondsToSelector:@selector(count)])
        {
            return i + [seq count];
        }
        i++;
    }
    return i;
}

@end
