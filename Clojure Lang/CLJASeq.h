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

@interface CLJASeq : CLJObj <CLJISeq, CLJSequential, NSCoding, CLJIHashEq>

- (id<CLJIPersistentCollection>)empty;
- (BOOL)equiv:(id)obj;
- (id)peek;
- (id<CLJIPersistentList>)pop;
- (id<CLJISeq>)rest;

@end

//public ISeq cons(Object o){
//	return new Cons(o, this);
//}
//
