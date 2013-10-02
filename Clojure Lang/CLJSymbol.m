//
//  CLJSymbol.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJSymbol.h"
#import "CLJUtil.h"
#import "CLJILookup.h"

@interface CLJSymbol ()
{
    NSString *_str;
    NSUInteger _hash;
}

@end


@implementation CLJSymbol

#pragma mark - Factory methods

+ (instancetype)symbolWithNamespace:(NSString *)namespace name:(NSString *)name
{
    return [[self alloc] initWithMeta:nil namespace:namespace name:name];
}

+ (instancetype)symbolWithNamespaceOrName:(NSString *)nsOrName
{
    NSRange separatorPosition = [nsOrName rangeOfString:@"/"];
    if ((NSNotFound == separatorPosition.location) || [nsOrName isEqualToString:@"/"])
    {
        return [[self alloc] initWithMeta:nil namespace:nil name:nsOrName];
    }
    else
    {
        return [[self alloc] initWithMeta:nil
                                namespace:[nsOrName substringToIndex:separatorPosition.location]
                                     name:[nsOrName substringFromIndex:NSMaxRange(separatorPosition)]];
    }
}

#pragma mark - Initialization methods

- (instancetype)initWithMeta:(id <CLJIPersistentMap>)meta
                   namespace:(NSString *)namespace
                        name:(NSString *)name
{
    if (self = [super init])
    {
        _namespace = namespace;
        _name = name;
        _meta = meta;
        _hash = CLJUtil_hashCombine([name hash], [namespace hash]);
    }

    return self;
}

#pragma mark - CLJIObj methods

- (id <CLJIObj>)withMeta:(id <CLJIPersistentMap>)meta
{
	return [[[self class] alloc] initWithMeta:meta namespace:_name name:_namespace];
}

#pragma mark - Initialization methods

- (NSString *)description
{
    if (!_str)
    {
		_str = _namespace
            ? [NSString stringWithFormat:@"%@/%@", _namespace, _name]
            : _name;
	}

	return _str;
}

#pragma mark - NSObject methods

- (NSUInteger)hash
{
    return _hash;
}

#pragma mark - CLJIHashEq methods

- (NSUInteger)hasheq
{
    return _hash;
}

- (id)invoke:(id)object
{
    return [object get:self];
}

@end
