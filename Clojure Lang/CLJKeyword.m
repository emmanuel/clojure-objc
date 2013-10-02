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

@interface CLJKeyword ()
{
    
}

@property (nonatomic, readwrite) NSString *str;

@end

@implementation CLJKeyword

+ (instancetype)keywordWithSymbol:(CLJSymbol *)symbol
{
    return [[self alloc] initWithSymbol:symbol];
}

+ (instancetype)keywordWithNamespaceOrName:(NSString *)namespaceOrName
{
    return [self keywordWithSymbol:[CLJSymbol symbolWithNamespaceOrName:namespaceOrName]];
}

#pragma mark - CLJIFn methods

- (id)invoke
{
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:[NSString stringWithFormat:@"Wrong number of args passed to keyword: %@", [self description]]
                                 userInfo:nil];
}

- (id)invoke:(id)arg
{
    return [arg get:self];
}

//- (id)invokeWithArgs:(id)arg1, ...
//{
//    
//}

//final public Object invoke(Object obj, Object notFound) {
//	if(obj instanceof ILookup)
//		return ((ILookup)obj).valAt(this,notFound);
//	return RT.get(obj, this, notFound);
//}



@end
