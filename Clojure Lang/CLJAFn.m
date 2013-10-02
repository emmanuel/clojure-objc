//
//  CLJAFn.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAFn.h"
#import "CLJISeq.h"

//static const NSUInteger boundedLength(id <CLJISeq> list, int limit) {
//	int i = 0;
//    id <CLJISeq> c;
//
//	for(c = list; c != nil && i <= limit; c = [c next]) {
//		i++;
//	}
//	return i;
//}


static const inline void CLJAFn_throwArity(NSUInteger actual, NSString *name)
{
    NSString *reason = [NSString stringWithFormat:@"Wrong number of args (%lu) passed to: %@", actual, name];
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:reason
                                 userInfo:nil];
}


@implementation CLJAFn

- (id)invoke
{
    CLJAFn_throwArity(0, NSStringFromClass([self class]));
    return nil;
}

- (id)invoke:(id)arg
{
    CLJAFn_throwArity(1, NSStringFromClass([self class]));
    return nil;
}

- (id)invokeWithArgs:(id)arg1, ...
{
    NSUInteger i = 0;

	if (nil != arg1) {
		va_list args;
		va_start(args, arg1);


//		i = 1;
//		id obj;
//		while((obj = va_arg(args, id))) {
//			i++;
//		}
		for (id arg = arg1; nil != arg; arg = va_arg(args, id), ++i)

		va_end(args);
	}

    CLJAFn_throwArity(i, NSStringFromClass([self class]));
    return nil;
}

- (id)call
{
    return [self invoke];
}

- (void)run
{
    [self invoke];
}

- (id)applyTo:(id<CLJISeq>)argumentSeq
{
    [self doesNotRecognizeSelector:@selector(applyTo:)];
    return nil;
}

@end
