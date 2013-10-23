//
//  CLJIPersistentHashMapNode.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIMapEntry.h"
#import "CLJAtomicReference.h"
#import "CLJISeq.h"
#import "CLJIFn.h"
#import "CLJBox.h"


@protocol CLJIPersistentHashMapNode <NSCoding>

- (id<CLJIPersistentHashMapNode>)assocKey:(id)key withObject:(id)object shift:(NSUInteger)shift hash:(NSUInteger)hash addedLeaf:(BOOL *)addedLeaf;
- (id<CLJIPersistentHashMapNode>)assocKey:(id)key withObject:(id)object editThread:(CLJAtomicReference *)edit shift:(NSUInteger)shift hash:(NSUInteger)hash addedLeaf:(BOOL *)addedLeaf;

- (id<CLJIPersistentHashMapNode>)withoutKey:(id)key shift:(NSUInteger)shift hash:(NSUInteger)hash;
- (id<CLJIPersistentHashMapNode>)withoutKey:(id)key editThread:(CLJAtomicReference *)edit shift:(NSUInteger)shift hash:(NSUInteger)hash removedLeaf:(BOOL *)removedLeaf;

- (id<CLJIMapEntry>)findKey:(id)key shift:(NSUInteger)shift hash:(NSUInteger)hash;
- (id)findKey:(id)key shift:(NSUInteger)shift hash:(NSUInteger)hash notFound:(id)notFound;

- (id<CLJISeq>)nodeSeq;

- (id)kvReduceWithFn:(id<CLJIFn>)fn initialObject:(id)initial;
- (id)foldWithFn:(id<CLJIFn>)combineFn reduceFn:(id<CLJIFn>)reducefn forkJoinTask:(id<CLJIFn>)fjTask forkJoinFork:(id<CLJIFn>)fjFork forkJoinJoin:(id<CLJIFn>)fjJoin;

@end
