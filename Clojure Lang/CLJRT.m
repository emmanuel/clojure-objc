//
//  CLJRT.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "CLJRT.h"
#import "CLJCategories.h"
#import "CLJIPersistentSet.h"


AINLINE id CLJRT_readTrueFalseUnknown(NSString *s)
{
    if ([s isEqualToString:@"true"])
    {
        return @(YES);
    }
    else if ([s isEqualToString:@"false"])
    {
        return @(NO);
    }

//    return Keyword.intern(null, "unknown");
    return nil;
}


// lifted from StackOverflow: http://stackoverflow.com/a/4330943
// and MAObjcRuntime: https://github.com/mikeash/MAObjCRuntime/blob/master/RTProtocol.m
AINLINE void CLJRT_addDefaultImplementationForClassOfProtocolFromImplementingClass(Class conformingClass, Protocol *proto, Class implementingClass)
{
    unsigned int count;
    BOOL isRequiredMethod = NO;
    BOOL isInstanceMethod = YES;
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(proto, isRequiredMethod, isInstanceMethod, &count);

    for(unsigned i = 0; i < count; i++)
    {
        SEL methodSelector = methods[i].name;
        Method existingMethod = class_getInstanceMethod(conformingClass, methodSelector);
        if (!existingMethod)
        {
            Method defaultMethod = class_getInstanceMethod(implementingClass, methodSelector);
            IMP defaultImplementation = method_getImplementation(defaultMethod);
            class_addMethod(conformingClass, methodSelector, defaultImplementation, methods[i].types);
        }
    }

    free(methods);
}
