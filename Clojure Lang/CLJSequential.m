//
//  Sequential.h
//  Clojure Lang
//
//  Copyright (c) 2013 Emmanuel Gomez.
//  Published under the Eclipse Public License
//

#import "CLJSequential.h"


@implementation CLJSequential

+ (void)addDefaultImplementationForClass:(Class)conformingClass
{
    CLJRT_addDefaultImplementationForClassOfProtocolFromImplementingClass(conformingClass,
                                                                          NSProtocolFromString(NSStringFromClass(self)),
                                                                          self);
}

- (id<CLJISeq>)seq
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

//- (id)nth:(NSUInteger)index
//{
//    id<CLJISeq> seq = [self seq];
//    // collection = nil;
//    NSUInteger i = 0;
//    
//    for (; (i < index) && (nil != seq); ++i, seq = [seq next]) {
//        if (i == index) return [seq first];
//    }
//    
//    NSString *reason = [NSString stringWithFormat:@"index (%lu) out of bounds (%lu)", (unsigned long)index, (unsigned long)i];
//    @throw [NSException exceptionWithName:NSRangeException
//                                   reason:reason
//                                 userInfo:nil];
//}

@end
