//
//  CLJArrayNode.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJPersistentHashMapUtil.h"
#import "CLJPersistentHashMapArrayNode.h"
#import "CLJPersistentHashMapBitmapIndexNode.h"


@interface CLJPersistentHashMapArrayNode ()

@property (nonatomic) NSInteger count;
@property (nonatomic) NSArray *array;
@property (atomic) NSThread *editThread;

@end



@implementation CLJPersistentHashMapArrayNode

- (instancetype)initWithEditThread:(NSThread *)editThread count:(NSInteger)count array:(NSArray *)array
{
    if (self = [super init])
    {
        self.editThread = editThread;
        self.count = count;
        self.array = array;
    }

    return self;
}

- (id<CLJPersistentHashMapINode>)assocWithShift:(NSInteger)shift hash:(NSInteger)hash key:(id)key value:(id)val addedLeaf:(id)addedLeaf
{
    // NSInteger index = [self maskHash:hash shift:shift];
    NSInteger index = CLJPersistentHashMapUtil_mask(hash, shift);
    id<CLJPersistentHashMapINode> node = self.array[index];
    if (nil == node)
    {
        NSArray *clone = [_array mutableCopy];
        [clone ]
        return [[[self class] alloc] initWithEditThread:nil count:(self.count + 1) array:[self cloneAndSetArray:self.array index:index node:[CLJPersistentHashMapBitmapIndexNode empty]]];
    }

    return node;
}

- (NSInteger)maskHash:(NSInteger)hash shift:(NSInteger)shift
{
    return hash ^ shift;
}

@end
