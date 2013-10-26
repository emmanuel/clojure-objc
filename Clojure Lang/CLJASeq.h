//
//  CLJASeq.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/19/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import "CLJObj.h"
#import "CLJISeq.h"
#import "CLJSequential.h"
#import "CLJIHashEq.h"
#import "CLJIPersistentList.h"

//public abstract class ASeq extends Obj implements ISeq, Sequential, List, Serializable, IHashEq {

@interface CLJASeq : CLJObj <CLJISeq, CLJSequential, CLJIHashEq, NSCoding>

- (id<CLJIPersistentCollection>)empty;
- (BOOL)equiv:(id)obj;
- (id<CLJISeq>)rest;

@end
