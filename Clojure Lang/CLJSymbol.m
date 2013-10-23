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
#import "NSString+CLJIntern.h"

@interface CLJSymbol ()

@property (nonatomic, strong, readwrite) NSString *ns;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong, readwrite) id<CLJIPersistentMap> meta;
@property (nonatomic) NSUInteger hash;

@end


@implementation CLJSymbol

#pragma mark - Factory methods

+ (instancetype)symbolWithNamespaceOrName:(NSString *)nsOrName
{
    NSRange separatorPosition = [nsOrName rangeOfString:@"/"];
    NSString *ns = nil;
    NSString *name = nil;
    if ((NSNotFound == separatorPosition.location) || [nsOrName isEqualToString:@"/"])
    {
        name = nsOrName;
    }
    else
    {
        ns = [nsOrName substringToIndex:separatorPosition.location];
        name = [nsOrName substringFromIndex:NSMaxRange(separatorPosition)];
    }

    return [[self alloc] initWithMeta:nil namespace:[ns clj_intern] name:[name clj_intern]];
}

+ (instancetype)symbolWithNamespace:(NSString *)ns name:(NSString *)name
{
    return [[self alloc] initWithMeta:nil namespace:[ns clj_intern] name:[name clj_intern]];
}

#pragma mark - Initialization methods

- (instancetype)initWithMeta:(id <CLJIPersistentMap>)meta namespace:(NSString *)nsInterned name:(NSString *)nameInterned
{
    if (self = [super init])
    {
        _ns = nsInterned;
        _name = nameInterned;
        _meta = meta;
        _hash = CLJUtil_hashCombine([nameInterned hash], [nsInterned hash]);
		_str = nil == _ns
                ? [NSString stringWithFormat:@"%@/%@", _ns, _name]
                : _name;
    }

    return self;
}


#pragma mark - CLJIObj methods

- (id <CLJIObj>)withMeta:(id <CLJIPersistentMap>)meta
{
	return [[[self class] alloc] initWithMeta:meta namespace:_ns name:_name];
}


#pragma mark - NSObject methods

- (NSString *)description
{
	return _str;
}

- (BOOL)isEqual:(id)object
{
    if (self == object) return YES;
    if (![object isKindOfClass:[self class]]) return NO;
    CLJSymbol *sym = (CLJSymbol *)object;
    return (_name == sym.name) && (_ns == sym.ns);
}


#pragma mark - CLJIHashEq methods

- (NSUInteger)clj_hasheq
{
    return _hash;
}

- (id)invoke:(id)object
{
    return [object get:self];
}

@end
