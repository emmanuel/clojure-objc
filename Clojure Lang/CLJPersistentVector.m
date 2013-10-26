//
//  CLJPersistentVector.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/30/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJPersistentVector.h"
#import "CLJPersistentVectorNode.h"
#import "NSArray+ArrayWithChanges.h"


@interface CLJPersistentVector ()

@property (nonatomic, strong) id<CLJIPersistentMap> meta;
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSUInteger shift;
@property (nonatomic, strong) CLJPersistentVectorNode *root;
@property (nonatomic, strong) NSArray *tail;

@end

@implementation CLJPersistentVector

+ (instancetype)empty
{
    static CLJPersistentVector *emptyVector;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emptyVector = [[self alloc] initWithMeta:nil
                                           count:0
                                           shift:kCLJPersistentVectorLevelBitPartitionWidth
                                            root:[CLJPersistentVectorNode empty]
                                            tail:@[ ]];
    });

    return emptyVector;
}

+ (instancetype)vectorWithMeta:(id<CLJIPersistentMap>)meta
                         count:(NSUInteger)count
                         shift:(NSUInteger)shift
                          root:(CLJPersistentVectorNode *)root
                          tail:(NSArray *)tail
{
    return [[self alloc] initWithMeta:meta count:count shift:shift root:root tail:tail];
}

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta
                       count:(NSUInteger)count
                       shift:(NSUInteger)shift
                        root:(CLJPersistentVectorNode *)root
                        tail:(NSArray *)tail
{
    if (self = [super init])
    {
        self.meta = meta;
        self.count = count;
        self.shift = shift;
        self.root = root;
        self.tail = tail;
    }

    return self;
}

#pragma mark - CLJIObj methods

- (instancetype)withMeta:(id<CLJIPersistentMap>)meta
{
    return [[self class] vectorWithMeta:meta count:self.count shift:self.shift root:self.root tail:self.tail];
}

#pragma mark - CLJIPersistentVector methods

- (instancetype)assocN:(NSUInteger)index withObject:(id)object
{
    // when using NSInteger:
    // if ((index >= 0) && (index < self.count))
    if (index < self.count)
    {
        // in tail
        if (index >= [self tailOff])
        {
            NSUInteger subIndex = index & kCLJPersistentVectorCurrentLevelMask;
            return [[self class] vectorWithMeta:self.meta
                                          count:self.count
                                          shift:self.shift
                                           root:self.root
                                           tail:[self.tail arrayWithIndex:subIndex setToObject:object]];
        }
        // in tree
        else
        {
            return [[self class] vectorWithMeta:self.meta
                                          count:self.count
                                          shift:self.shift
                                           root:[self doAssocWithLevel:self.shift
                                                                  node:self.root
                                                                 index:index
                                                                object:object]
                                           tail:self.tail];
        }
    }
    else if (index == self.count)
    {
        return [self cons:object];
    }
    else
    {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:[NSString stringWithFormat:@"invalid index %li", (long)index]
                                     userInfo:nil];
    }
}

#pragma mark - CLJIPersistentCollection methods

- (CLJPersistentVector *)cons:(id)object
{
    // TODO: what is this for?
    // NSInteger i = self.count;

    // Room in tail?
    if ((self.count - [self tailOff]) < kCLJPersistentVectorBranchingFactor)
    {
        return [[self class] vectorWithMeta:self.meta
                                      count:(self.count + 1)
                                      shift:self.shift
                                       root:self.root
                                       tail:[self.tail arrayByAddingObject:object]];
    }
    // Full tail, push into tree
    else
    {
        CLJPersistentVectorNode *newRoot = nil;
        CLJPersistentVectorNode *tailNode = [self.root nodeWithArray:self.tail];
        NSUInteger newShift = self.shift;

        // overflow root?
        if ((self.count >> kCLJPersistentVectorLevelBitPartitionWidth) > (1 << self.shift))
        {
            newRoot = [self.root nodeWithArray:@[ ]];
            CLJPersistentVectorNode *nodeWithPathToTailNode = [self nodeWithWithPathToNode:tailNode
                                                                                editThread:self.root.editThread
                                                                                     level:self.shift];
            newRoot.array = @[ self.root, nodeWithPathToTailNode ];
            newShift += kCLJPersistentVectorLevelBitPartitionWidth;
        }
        else
        {
            newRoot = [self pushTailNode:tailNode withParent:self.root level:self.shift];
            if (newRoot == nil) NSLog(@"pushTailNode:withParent:level: returned a nil node: %@", self);
        }
        
        return [[self class] vectorWithMeta:self.meta
                                      count:(self.count + 1)
                                      shift:newShift
                                       root:newRoot
                                       tail:@[ object ]];
    }
}

#pragma mark - CLJIPersistentStack methods

- (CLJPersistentVector *)pop
{
    if (self.count == 0)
    {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"can't pop empty vector" userInfo:nil];
    }
    else if (self.count == 1)
    {
        return [[[self class] empty] withMeta:self.meta];
    }
    // Pop tail
    else if ((self.count - [self tailOff]) > 1)
    {
        return [[self class] vectorWithMeta:self.meta
                                      count:(self.count - 1)
                                      shift:self.shift
                                       root:self.root
                                       tail:[self.tail arrayByRemovingLastObject]];
    }
    // Pop tree
    else
    {
        NSArray *newTail = [self arrayForIndex:(self.count - 2)];
        CLJPersistentVectorNode *newRoot = [self popTailWithLevel:self.shift node:self.root];
        NSUInteger newShift = self.shift;
        if (newRoot == nil)
        {
            newRoot = [CLJPersistentVectorNode empty];
        }
        // omit what would be an empty root
        else if ((self.shift > kCLJPersistentVectorLevelBitPartitionWidth) && ([newRoot.array count] == 1))
        {
            newRoot = [newRoot.array firstObject];
            newShift -= kCLJPersistentVectorLevelBitPartitionWidth;
        }
        return [[self class] vectorWithMeta:self.meta
                                      count:(self.count - 1)
                                      shift:newShift
                                       root:newRoot
                                       tail:newTail];
    }
}

#pragma mark - Private/Internal methods

- (CLJPersistentVectorNode *)doAssocWithLevel:(NSUInteger)level node:(CLJPersistentVectorNode *)node index:(NSInteger)index object:(id)object;
{
    NSUInteger subIndex = NSUIntegerMax;
    id newObject = nil;
    
    if (level == 0)
    {
        subIndex = index & kCLJPersistentVectorCurrentLevelMask;
        newObject = object;
    }
    else
    {
        subIndex = (index >> level) & kCLJPersistentVectorCurrentLevelMask;
        newObject = [self doAssocWithLevel:(level - kCLJPersistentVectorLevelBitPartitionWidth)
                                      node:node.array[subIndex]
                                     index:index
                                    object:object];
    }
    
    return [node nodeWithArray:[node.array arrayWithIndex:subIndex setToObject:newObject]];
}

- (CLJPersistentVectorNode *)nodeWithWithPathToNode:(CLJPersistentVectorNode *)targetNode
                                         editThread:(NSThread *)editThread
                                              level:(NSUInteger)level
{
    if (level == 0)
    {
        return targetNode;
    }
    else
    {
        // temp variable is in source... does order of init matter?
        // (eager evaluation would have the outer node allocated last without the explicit preceding init
        // CLJPersistentVectorNode *ret = [targetNode nodeWithArray:@[ ]];
        CLJPersistentVectorNode *ret = [CLJPersistentVectorNode nodeWithEditThread:editThread
                                                                             array:@[ ]];
        CLJPersistentVectorNode *firstEntry = [self nodeWithWithPathToNode:targetNode
                                                                editThread:editThread
                                                                     level:(level - kCLJPersistentVectorLevelBitPartitionWidth)];
        ret.array = [ret.array arrayByAddingObject:firstEntry];
        return ret;
    }
}

- (CLJPersistentVectorNode *)pushTailNode:(CLJPersistentVectorNode *)tailNode
                               withParent:(CLJPersistentVectorNode *)parent
                                    level:(NSUInteger)level

{
    //if parent is leaf, insert node,
	// else does it map to an existing child? -> nodeToInsert = pushNode one more level
	// else alloc new path
	//return  nodeToInsert placed in copy of parent
    NSInteger subIndex = ((self.count - 1) >> level) & kCLJPersistentVectorCurrentLevelMask;
    CLJPersistentVectorNode *ret = [parent nodeWithArray:@[ ]];
    CLJPersistentVectorNode *nodeToInsert;
    if (level == kCLJPersistentVectorLevelBitPartitionWidth)
    {
        nodeToInsert = tailNode;
    }
    else
    {
        CLJPersistentVectorNode *nodeToInsert;
        // CLJPersistentVectorNode *child = [parent.array objectAtIndex:subIndex];
        // if (child != nil)
        if (subIndex < [parent.array count])
        {
            CLJPersistentVectorNode *child = [parent.array objectAtIndex:subIndex];
            nodeToInsert = [self pushTailNode:tailNode withParent:child level:(level - kCLJPersistentVectorLevelBitPartitionWidth)];
            if (nodeToInsert == nil) NSLog(@"got nil node from pushTailNode:withParent:level:, vec: %@", self);
        }
        else
        {
            nodeToInsert = [self nodeWithWithPathToNode:tailNode
                                             editThread:self.root.editThread
                                                  level:(level - kCLJPersistentVectorLevelBitPartitionWidth)];
            if (nodeToInsert == nil) NSLog(@"got nil node from nodeWithPathToNode, vec: %@", self);
        }
    }
    // NSMutableArray *temp = [parent.array mutableCopy];
    // temp[subIndex] = nodeToInsert;
    // [temp setObject:nodeToInsert atIndexedSubscript:subIndex];
    // ret.array = [NSArray arrayWithArray:temp];
    ret.array = [parent.array arrayByAddingObject:nodeToInsert];

    return ret;
}

- (NSInteger)tailOff
{
    if (self.count < kCLJPersistentVectorBranchingFactor)
    {
        return 0;
    }
    else
    {
        // TODO: Clojure source uses `>>>`, unsigned right bit shift operator
        //  operating on a 32-bit signed integer with a two's complement representation
        //  I'm not exactly sure what the equivalent is in terms of the mix of operators,
        //  integer types (bit widths, ifdef typedefs, etc), & platforms (endianness?)
        return ((self.count - 1) >> kCLJPersistentVectorLevelBitPartitionWidth) << kCLJPersistentVectorLevelBitPartitionWidth;
    }
}

- (NSArray *)arrayForIndex:(NSInteger)index
{
    if ((index >= 0) && (index < self.count))
    {
        if (index >= [self tailOff])
        {
            return self.tail;
        }
        else
        {
            CLJPersistentVectorNode *node = self.root;
            NSUInteger subIndex = 0;
            for (NSUInteger level = self.shift; level > 0; level -= kCLJPersistentVectorLevelBitPartitionWidth) {
                subIndex = ((index >> level) & kCLJPersistentVectorCurrentLevelMask);
                node = [node.array objectAtIndex:subIndex];
            }

            return node.array;
        }
    }
    else
    {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:[NSString stringWithFormat:@"index out of bounds: %lu", (long)index]
                                     userInfo:nil];
    }
}

- (CLJPersistentVectorNode *)popTailWithLevel:(NSUInteger)level node:(CLJPersistentVectorNode *)node
{
    NSInteger subIndex = ((self.count - 2) >> level) & kCLJPersistentVectorCurrentLevelMask;
    // non-leaf?
    if (level > kCLJPersistentVectorLevelBitPartitionWidth)
    {
        CLJPersistentVectorNode *newChild = [self popTailWithLevel:(level - kCLJPersistentVectorLevelBitPartitionWidth)
                                                              node:node.array[subIndex]];
        if ((newChild == nil) && (subIndex == 0))
        {
            return nil;
        }
        // new intermediary node on path
        else
        {
            return [node nodeWithArray:[node.array arrayWithIndex:subIndex setToObject:newChild]];
        }
    }
    // level is beyond current tree depth
    else if (subIndex == 0)
    {
        return nil;
    }
    // pop the tail
    else
    {
        return [node nodeWithArray:[node.array arrayByRemovingLastObject]];
    }
}


#pragma mark - CLJIndexed methods

- (id)nth:(NSUInteger)index
{
    NSArray *targetArray = [self arrayForIndex:index];
    return [targetArray objectAtIndex:(index & kCLJPersistentVectorCurrentLevelMask)];
}

//public Object nth(int i){
//	Object[] node = arrayFor(i);
//	return node[i & 0x01f];
//}

#pragma mark - CLJIPersistentCollection methods

- (id<CLJIPersistentCollection>)empty
{
    return [[[self class] empty] withMeta:self.meta];
}

@end
