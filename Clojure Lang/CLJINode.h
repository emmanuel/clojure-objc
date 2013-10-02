//
//  CLJINode.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLJISeq;
@protocol CLJIFn;
@protocol CLJIMapEntry;


@protocol CLJINode <NSCoding>

- (id <CLJINode)assoc:(NSUInteger)shift, (NSInteger)hash, (id)key, (id)val, (Box)addedLeaf;
- (id <CLJINode)without:(NSUInteger)shift, (NSInteger)hash, (id)key;
- (id <CLJIMapEntry>)find:(NSUInteger)shift, (NSInteger)hash, (id)key, (id)notFound;
- (id <CLJISeq>)nodeSeq;

//INode assoc(AtomicReference<Thread> edit, int shift, int hash, Object key, Object val, Box addedLeaf);
//INode without(AtomicReference<Thread> edit, int shift, int hash, Object key, Box removedLeaf);
//- (id <CLJINode>)assoc

- (id)kvreduce:(id <CLJIFn>)f, (id)init;
- (id)fold:(id <CLJIFn>)combineFn, (id <CLJIFn>)reduceFn, (id <CLJIFn>)fjTask, (id <CLJIFn>)fjFork, (id <CLJIFn>)fjJoin;

@end
