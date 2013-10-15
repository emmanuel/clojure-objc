//
//  CLJPersistentList.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJASeq.h"
#import "CLJIPersistentList.h"
#import "CLJCounted.h"

@interface CLJPersistentList : CLJASeq <CLJIPersistentList, CLJCounted>

@property (nonatomic, readonly, strong) id first;
@property (nonatomic, readonly, strong) id<CLJIPersistentList> rest;
@property (nonatomic, readonly) NSUInteger count;

+ (CLJPersistentList *)empty;

- (CLJPersistentList *)cons:(id)object;

@end
