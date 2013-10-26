//
//  CLJKeyword.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/23/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJKeyword.h"
#import "CLJSymbol.h"
#import "CLJILookup.h"
#import "CLJRT.h"
#import <objc/runtime.h>


@interface CLJKeyword ()

@property (nonatomic, readwrite) NSUInteger hash;
@property (nonatomic, readwrite) NSString *str;

@end


@implementation CLJKeyword

@synthesize ns;
@synthesize name;

#pragma mark - Factory methods

+ (instancetype)keywordWithSymbol:(CLJSymbol *)symbol
{
    return [[self alloc] initWithSymbol:symbol];
}

+ (instancetype)keywordWithNamespaceOrName:(NSString *)namespaceOrName
{
    return [[self alloc] initWithSymbol:[CLJSymbol symbolWithNamespaceOrName:namespaceOrName]];
}

+ (instancetype)keywordWithNamespace:(NSString *)namespace name:(NSString *)name
{
    return [[self alloc] initWithSymbol:[CLJSymbol symbolWithNamespace:namespace name:name]];
}

#pragma mark - Initialization methods

- (instancetype)initWithSymbol:(CLJSymbol *)symbol
{
    if (self = [super init])
    {
        _sym = symbol;
        _hash = [symbol hash] + 0x9e3779b9;
    }

    return self;
}

#pragma mark - CLJIHashEq methods

- (NSUInteger)clj_hasheq
{
    return _hash;
}

#pragma mark - CLJIFn methods

- (id)invoke
{
    NSString *reason = [NSString stringWithFormat:@"Wrong number of args passed to keyword: %@", [self description]];
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
}

- (id)invoke:(id)arg
{
    return [arg get:self];
}

- (id)invokeWithArgs:(id)arg1, ...
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

//final public Object invoke(Object obj, Object notFound) {
//	if(obj instanceof ILookup)
//		return ((ILookup)obj).valAt(this,notFound);
//	return RT.get(obj, this, notFound);
//}

- (id)applyTo:(id<CLJISeq>)argumentSeq
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
