//
//  CLJIPersistentCollection.h
//  Clojure Lang
//
//  Copyright (c) 2013 Emmanuel Gomez.
//  Published under the Eclipse Public License
//

#import <Foundation/Foundation.h>
#import "CLJIPersistentCollection.h"
#import "CLJRT.h"


@implementation CLJIPersistentCollection

+ (void)addDefaultImplementationForClass:(Class)conformingClass
{
    // CLJRT_addDefaultImplementationForClassOfProtocolFromImplementingClass(conformingClass,
    //                                                                       NSProtocolFromString(NSStringFromClass(self)),
    //                                                                       self);
}

//- (NSUInteger)count
//{
//    id<CLJISeq> seq = [self seq];
//    int i = 0;
//    // TODO: add NSFastEnumeration support to CLJISeq
//    for(; nil != seq; seq = [seq next]) {
//        if ([seq respondsToSelector:@selector(count)])
//        {
//            return i + [seq count];
//        }
//        i++;
//    }
//    return i;
//}

- (id<CLJIPersistentCollection>)empty
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (BOOL)equiv:(id)object
{
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

- (id<CLJIPersistentCollection>)cons:(id)object
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id<CLJISeq>)seq
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
