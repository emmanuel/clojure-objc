//
//  CLJPersistentHashMapINode.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJIMapEntry.h"
#import "CLJISeq.h"
#import "CLJIFn.h"


@protocol CLJPersistentHashMapINode <NSCoding>

- (id<CLJPersistentHashMapINode>)assocWithShift:(NSInteger)shift
                                           hash:(NSInteger)hash
                                            key:(id)key
                                          value:(id)val
                                      addedLeaf:(id)addedLeaf;

- (id<CLJPersistentHashMapINode>)withoutWithShift:(NSInteger)shift
                                             hash:(NSInteger)hash
                                              key:(id)key;

- (id<CLJIMapEntry>)findWithShift:(NSInteger)shift
                             hash:(NSInteger)hash
                              key:(id)key;

- (id)findWithShift:(NSInteger)shift
               hash:(NSInteger)hash
                key:(id)key
           notFound:(id)notFound;

- (id<CLJISeq>)nodeSeq;

- (id<CLJPersistentHashMapINode>)assocWithEditThread:(NSThread *)edit
                                               shift:(NSInteger)shift
                                                hash:(NSInteger)hash
                                                 key:(id)key
                                               value:(id)val
                                           addedLeaf:(NSValue)addedLeaf;

- (id<CLJPersistentHashMapINode>)withoutWithEditThread:(NSThread *)edit
                                                 shift:(NSInteger)shift
                                                  hash:(NSInteger)hash
                                                   key:(id)key
                                           removedLeaf:(id)removedLeaf;

- (id)kvReduceWithFn:(id<CLJIFn>)fn initialObject:(id)initial;

- (id)foldWithFn:(id<CLJIFn>)combineFn
        reduceFn:(id<CLJIFn>)reducefn
    forkJoinTask:(id<CLJIFn>)fjTask
    forkJoinFork:(id<CLJIFn>)fjFork
    forkJoinJoin:(id<CLJIFn>)fjJoin;

@end
