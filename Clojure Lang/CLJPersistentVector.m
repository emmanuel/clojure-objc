//
//  CLJPersistentVector.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/30/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJPersistentVector.h"
#import "CLJPersistentVectorNode.h"


@interface CLJPersistentVector ()

@property (nonatomic, strong) id<CLJIPersistentMap> meta;
@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger shift;
@property (nonatomic, strong) CLJPersistentVectorNode *root;
@property (nonatomic, strong) NSArray *tail;

@end

@implementation CLJPersistentVector

+ (CLJPersistentVector *)empty
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
                         count:(NSInteger)count
                         shift:(NSInteger)shift
                          root:(CLJPersistentVectorNode *)root
                          tail:(NSArray *)tail
{
    return [[self alloc] initWithMeta:meta count:count shift:shift root:root tail:tail];
}

- (instancetype)initWithMeta:(id<CLJIPersistentMap>)meta
                       count:(NSInteger)count
                       shift:(NSInteger)shift
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

- (instancetype)withMeta:(id<CLJIPersistentMap>)meta
{
    return [[self class] vectorWithMeta:meta count:self.count shift:self.shift root:self.root tail:self.tail];
}

- (instancetype)assocN:(NSInteger)index withObject:(id)object
{
    if ((index >= 0) && (index < self.count))
    {
        if (index > [self tailOff])
        {
            NSMutableArray *newTail = [self.tail mutableCopy];
            [newTail replaceObjectAtIndex:(index & kCLJPersistentVectorCurrentLevelMask)
                               withObject:object];

            return [[self class] vectorWithMeta:self.meta
                                          count:self.count
                                          shift:self.shift
                                           root:self.root
                                           tail:[NSArray arrayWithArray:newTail]];
        }
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

- (CLJPersistentVectorNode *)doAssocWithLevel:(NSInteger)level node:(CLJPersistentVectorNode *)node index:(NSInteger)index object:(id)object;
{
    CLJPersistentVectorNode *ret = [node nodeWithArray:@[ ]];
    NSMutableArray *temp = [node.array mutableCopy];
    if (level == 0)
    {
        [temp replaceObjectAtIndex:(index & kCLJPersistentVectorCurrentLevelMask)
                        withObject:object];
    }
    else
    {
        NSInteger subIndex = (index >> level) & kCLJPersistentVectorCurrentLevelMask;
        CLJPersistentVectorNode *newNode = [self doAssocWithLevel:(level - kCLJPersistentVectorLevelBitPartitionWidth)
                                                             node:node.array[subIndex]
                                                            index:index
                                                           object:object];
        [temp replaceObjectAtIndex:subIndex withObject:newNode];
    }
    ret.array = [NSArray arrayWithArray:temp];

    return ret;
}

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
        CLJPersistentVectorNode *newRoot;
        CLJPersistentVectorNode *tailNode = [self.root nodeWithArray:self.tail];
        NSInteger newShift = self.shift;

        // overflow root?
        if ((self.count >> kCLJPersistentVectorLevelBitPartitionWidth) > (1 << self.shift))
        {
            CLJPersistentVectorNode *newRoot = [self.root nodeWithArray:@[ ]];
            CLJPersistentVectorNode *pathFromRootToTailNode = [self nodeWithWithPathToNode:tailNode
                                                                                editThread:self.root.editThread
                                                                                     level:self.shift];
            newRoot.array = @[ self.root, pathFromRootToTailNode ];
            newShift += kCLJPersistentVectorLevelBitPartitionWidth;
        }
        else
        {
            newRoot = [self pushTailWithLevel:self.shift parent:self.root tailNode:tailNode];
        }
        
        return [CLJPersistentVector vectorWithMeta:self.meta
                                             count:(self.count + 1)
                                             shift:newShift
                                              root:newRoot
                                              tail:@[ object ]];
    }
}

- (CLJPersistentVectorNode *)nodeWithWithPathToNode:(CLJPersistentVectorNode *)targetNode
                                         editThread:(NSThread *)editThread
                                              level:(NSInteger)level
{
    if (level == 0)
    {
        return targetNode;
    }
    else
    {
        // temp variable is in source... does order of init matter? (eager evaluation would have the outer node allocated last without the explicit preceding init
        CLJPersistentVectorNode *ret = [CLJPersistentVectorNode nodeWithEditThread:editThread
                                                                             array:@[ ]];
        CLJPersistentVectorNode *firstEntry = [self nodeWithWithPathToNode:targetNode
                                                                editThread:editThread
                                                                     level:(level - kCLJPersistentVectorLevelBitPartitionWidth)];
        ret.array = [ret.array arrayByAddingObject:firstEntry];
        return ret;
    }
}

- (CLJPersistentVectorNode *)pushTailWithLevel:(NSInteger)level
                                        parent:(CLJPersistentVectorNode *)parent
                                      tailNode:(CLJPersistentVectorNode *)tailNode
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
        CLJPersistentVectorNode *child;
        CLJPersistentVectorNode *nodeToInsert;
        // CLJPersistentVectorNode *child = [parent.array objectAtIndex:subIndex];
        // if (child != nil)
        if (subIndex < [parent.array count])
        {
            child = [parent.array objectAtIndex:subIndex];
            nodeToInsert = [self pushTailWithLevel:(level - kCLJPersistentVectorLevelBitPartitionWidth)
                                            parent:child
                                          tailNode:tailNode];
        }
        else
        {
            nodeToInsert = [self nodeWithWithPathToNode:tailNode
                                             editThread:self.root.editThread
                                                  level:(level - kCLJPersistentVectorLevelBitPartitionWidth)];
        }
    }
    NSMutableArray *temp = [parent.array mutableCopy];
    [temp replaceObjectAtIndex:subIndex withObject:nodeToInsert];
    ret.array = [NSArray arrayWithArray:temp];
    
    return ret;
}

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
        NSArray *newTail = [self.tail subarrayWithRange:NSMakeRange(0, [self.tail count] - 1)];

        return [[self class] vectorWithMeta:self.meta
                                      count:(self.count - 1)
                                      shift:self.shift
                                       root:self.root
                                       tail:newTail];
    }
    // Pop tree
    else
    {
        NSArray *newTail = [self arrayForIndex:(self.count - 2)];
        CLJPersistentVectorNode *newRoot = [self popTailWithLevel:self.shift node:self.root];
        NSInteger newShift = self.shift;
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
            NSInteger subIndex = 0;
            for (NSInteger level = self.shift; level > 0; level -= kCLJPersistentVectorLevelBitPartitionWidth) {
                subIndex = ((index >> level) & kCLJPersistentVectorCurrentLevelMask);
                node = [node.array objectAtIndex:subIndex];
            }

            return node.array;
        }
    }
    else
    {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:[NSString stringWithFormat:@"index out of bounds: %lu", index]
                                     userInfo:nil];
    }
}

- (CLJPersistentVectorNode *)popTailWithLevel:(NSInteger)level node:(CLJPersistentVectorNode *)node
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
            CLJPersistentVectorNode *ret = [self.root nodeWithArray:@[ ]];
            NSMutableArray *temp = [node.array mutableCopy];
            [temp replaceObjectAtIndex:subIndex withObject:newChild];
            ret.array = [NSArray arrayWithArray:temp];
            return ret;
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
        // TODO: does the order of initialization matter? could do this in one call if not
        CLJPersistentVectorNode *ret = [self.root nodeWithArray:@[ ]];
        ret.array = [node.array subarrayWithRange:NSMakeRange(0, [node.array count] - 1)];

        return ret;
    }
}


#pragma mark - CLJIPersistentCollection methods

- (id<CLJIPersistentCollection>)empty
{
    return [[[self class] empty] withMeta:self.meta];
}

@end
