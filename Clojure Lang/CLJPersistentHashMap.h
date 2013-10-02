//
//  CLJPersistentHashMap.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJAPersistentMap.h"
#import "CLJIEditableCollection.h"
#import "CLJIObj.h"

@protocol CLJPersistentHashMapINode;
@protocol CLJISeq;

@interface CLJPersistentHashMap : CLJAPersistentMap <CLJIEditableCollection, CLJIObj>

+ (instancetype)empty;

+ (instancetype)createWithKeysAndValues:(id)arg, ... NS_REQUIRES_NIL_TERMINATION;
+ (instancetype)createWithCheckWithKeysAndValues:(id)arg, ... NS_REQUIRES_NIL_TERMINATION;
+ (instancetype)createWithSeq:(id <CLJISeq>)seq;
+ (instancetype)createWithCheckWithSeq:(id <CLJISeq>)seq;

+ (instancetype)createWithMeta:(id <CLJIPersistentMap>)meta keysAndValues:(id)arg, ... NS_REQUIRES_NIL_TERMINATION;
+ (instancetype)createWithCheckWithMeta:(id <CLJIPersistentMap>)meta seq:(id <CLJISeq>)seq;

@end
