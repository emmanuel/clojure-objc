//
//  CLJPersistentHashMap.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJPersistentHashMap.h"
#import "CLJPersistentHashMapBitmapIndexNode.h"
#import "CLJBox.h"

@protocol CLJIPersistentHashMapNode;



@interface CLJPersistentHashMap ()

@property (nonatomic) NSUInteger count;
@property (nonatomic, strong) id<CLJIPersistentHashMapNode> root;
@property (nonatomic) BOOL hasNil;
@property (nonatomic, strong) id nilValue;
@property (nonatomic, strong) id<CLJIPersistentMap> meta;

@end


@implementation CLJPersistentHashMap

#pragma mark - Singleton methods

+ (CLJPersistentHashMap *)empty
{
    static CLJPersistentHashMap *empty;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        empty = [[self alloc] initWithMeta:nil count:0 root:nil hasNilValue:NO nilValue:nil];
    });

    return empty;
}

+ (id)notFound
{
    static id notFound = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notFound = [[NSObject alloc] init];
    });

    return notFound;
}

#pragma mark - Factory methods

+ (instancetype)hashMapWithMeta:(id<CLJIPersistentMap>)meta count:(NSUInteger)count rootNode:(id<CLJIPersistentHashMapNode>)root hasNilValue:(BOOL)hasNilValue nilValue:(id)nilValue
{
    return [[self alloc] initWithMeta:meta count:count root:root hasNilValue:hasNilValue nilValue:nilValue];
}

#pragma mark - Initialization methods

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta count:(NSUInteger)count root:(id<CLJIPersistentHashMapNode>)root hasNilValue:(BOOL)hasNilValue nilValue:(id)nilValue
{
    if (self = [super init])
    {
        self.meta = meta;
        self.count = count;
        self.root = root;
        self.hasNil = hasNilValue;
        self.nilValue = nilValue;
    }

    return self;
}

#pragma mark - CLJIPersistentMap

- (id<CLJIPersistentMap>)assocKey:(id)key withObject:(id)object
{
    if (nil == key)
    {
        if (self.hasNil && (self.nilValue == object)) return self;

        return [CLJPersistentHashMap hashMapWithMeta:self.meta
                                               count:self.count
                                            rootNode:self.root
                                         hasNilValue:YES
                                            nilValue:object];
	}
    BOOL addedLeaf = NO;
    id<CLJIPersistentHashMapNode> newRoot = nil == self.root ? nil : [CLJPersistentHashMapBitmapIndexNode empty];
    newRoot = [newRoot assocKey:key withObject:object shift:0 hash:0 addedLeaf:&addedLeaf];
    if (newRoot == self.root) return self;
    return [CLJPersistentHashMap hashMapWithMeta:self.meta count:(self.count + (addedLeaf ? 1 : 0)) rootNode:newRoot hasNilValue:self.hasNil nilValue:self.nilValue];
}

- (BOOL)containsKey:(id)key
{
    if (nil == key) return self.hasNil;
    if (nil != self.root)
    {
        id notFound = [CLJPersistentHashMap notFound];
        id found = [self.root findKey:key withShift:0 hash:[key clj_hasheq] notFound:notFound];
        return notFound != found;
    }
    else
    {
        return NO;
    }
}

@end

//public class PersistentHashMap extends APersistentMap implements IEditableCollection, IObj {
//
//
//    final public static PersistentHashMap EMPTY = new PersistentHashMap(0, null, false, null);
//    final private static Object NOT_FOUND = new Object();
//
//    static public IPersistentMap create(Map other){
//        ITransientMap ret = EMPTY.asTransient();
//        for(Object o : other.entrySet())
//		{
//            Map.Entry e = (Entry) o;
//            ret = ret.assoc(e.getKey(), e.getValue());
//		}
//        return ret.persistent();
//    }
//
//    /*
//     * @param init {key1,val1,key2,val2,...}
//     */
//    public static PersistentHashMap create(Object... init){
//        ITransientMap ret = EMPTY.asTransient();
//        for(int i = 0; i < init.length; i += 2)
//		{
//            ret = ret.assoc(init[i], init[i + 1]);
//		}
//        return (PersistentHashMap) ret.persistent();
//    }
//
//    public static PersistentHashMap createWithCheck(Object... init){
//        ITransientMap ret = EMPTY.asTransient();
//        for(int i = 0; i < init.length; i += 2)
//		{
//            ret = ret.assoc(init[i], init[i + 1]);
//            if(ret.count() != i/2 + 1)
//                throw new IllegalArgumentException("Duplicate key: " + init[i]);
//		}
//        return (PersistentHashMap) ret.persistent();
//    }
//
//    static public PersistentHashMap create(ISeq items){
//        ITransientMap ret = EMPTY.asTransient();
//        for(; items != null; items = items.next().next())
//		{
//            if(items.next() == null)
//                throw new IllegalArgumentException(String.format("No value supplied for key: %s", items.first()));
//            ret = ret.assoc(items.first(), RT.second(items));
//		}
//        return (PersistentHashMap) ret.persistent();
//    }
//
//    static public PersistentHashMap createWithCheck(ISeq items){
//        ITransientMap ret = EMPTY.asTransient();
//        for(int i=0; items != null; items = items.next().next(), ++i)
//		{
//            if(items.next() == null)
//                throw new IllegalArgumentException(String.format("No value supplied for key: %s", items.first()));
//            ret = ret.assoc(items.first(), RT.second(items));
//            if(ret.count() != i + 1)
//                throw new IllegalArgumentException("Duplicate key: " + items.first());
//		}
//        return (PersistentHashMap) ret.persistent();
//    }
//
//    /*
//     * @param init {key1,val1,key2,val2,...}
//     */
//    public static PersistentHashMap create(IPersistentMap meta, Object... init){
//        return create(init).withMeta(meta);
//    }
//
