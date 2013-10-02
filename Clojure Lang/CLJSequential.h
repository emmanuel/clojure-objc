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


@implementation CLJSequential

+ (void)addDefaultImplementationForClass:(Class)conformingClass
{
    CLJRT_addDefaultImplementationForClassOfProtocolFromImplementingClass(conformingClass,
                                                                          NSProtocolFromString(NSStringFromClass(self)),
                                                                          self);
}

- (id)nth:(NSUInteger)index
{
    id<CLJISeq> seq = [self seq];
    collection = nil;
    NSUInteger i = 0;
    
    for (; (i < index) && (nil != seq); ++i, seq = [seq next]) {
        if (i == index) return [seq first];
    }
    
    NSString *reason = [NSString stringWithFormat:@"index (%lu) out of bounds (%lu)", index, i];
    @throw [NSException exceptionWithName:NSRangeException
                                   reason:reason
                                 userInfo:nil];
}

@end