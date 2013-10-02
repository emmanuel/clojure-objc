//
//  CLJIMapEntry.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIndexed.h"

@protocol CLJIMapEntry

- (id)key;
- (id)val;


@optional
- (id)nth:(NSInteger)index;
- (id)nth:(NSInteger)index withDefault:(id)notFound;

@end


@interface CLJIMapEntry : NSObject <CLJIMapEntry>

+ (void)addDefaultImplementationForClass:(Class)conformingClass;

@end


@implementation CLJIMapEntry

+ (void)addDefaultImplementationForClass:(Class)conformingClass
{
    CLJRT_addDefaultImplementationForClassOfProtocolFromImplementingClass(conformingClass,
                                                                          NSProtocolFromString(NSStringFromClass(self)),
                                                                          self);
}


- (id)nth:(NSInteger)index
{
    switch (index) {
        case 0:
            return [self key];
            break;
        case 1:
            return [self val];
            break;
        default:
            @throw [NSException exceptionWithName:NSRangeException
                                           reason:[NSString stringWithFormat:@"index (%lu) out of bounds (%i)", index, 1]
                                         userInfo:nil];
            break;
    }
}

- (id)nth:(NSInteger)index withDefault:(id)notFound
{
    return [self nth:index] ?: notFound;
}

@end