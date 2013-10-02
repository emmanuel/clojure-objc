//
//  CLJAPersistentMap.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/NSException.h>
#import "CLJAPersistentMap.h"
#import "CLJISeq.h"
#import "CLJIMapEntry.h"
#import "CLJIPersistentVector.h"

@implementation CLJAPersistentMap

- (id<CLJIPersistentCollection>)cons:(id)object
{
    if ([object conformsToProtocol:@protocol(CLJIMapEntry)])
    {
        id <CLJIMapEntry> mapEntry = (id <CLJIMapEntry>)object;
        return [self assocKey:[mapEntry key] withValue:[mapEntry val]];
    }
    else if ([object conformsToProtocol:@protocol(CLJIPersistentVector)])
    {
        id <CLJIPersistentVector> vector = (id <CLJIPersistentVector>) object;
        if (2 != [vector count])
        {
            @throw [NSException exceptionWithName:NSInvalidArgumentException
                                           reason:@"Vector arg to map conj must be a pair"
                                         userInfo:nil];
        }

        return [self assocKey:[vector nth:0] withValue:[vector nth:1]];
    }

    id <CLJIPersistentMap> returnValue = self;

    for (id <CLJISeq> es = [object seq]; es != nil; es = [es next]) {
        id <CLJIMapEntry> mapEntry = (id <CLJIMapEntry>)[es first];
        returnValue = [returnValue assocKey:[mapEntry key] withValue:[mapEntry val]];
    }

    return returnValue;
}

//public IPersistentCollection cons(Object o){
//	if(o instanceof Map.Entry)
//    {
//		Map.Entry e = (Map.Entry) o;
//        
//		return assoc(e.getKey(), e.getValue());
//    }
//	else if(o instanceof IPersistentVector)
//    {
//		IPersistentVector v = (IPersistentVector) o;
//		if(v.count() != 2)
//			throw new IllegalArgumentException("Vector arg to map conj must be a pair");
//		return assoc(v.nth(0), v.nth(1));
//    }
//    
//	IPersistentMap ret = this;
//	for(ISeq es = RT.seq(o); es != null; es = es.next())
//    {
//		Map.Entry e = (Map.Entry) es.first();
//		ret = ret.assoc(e.getKey(), e.getValue());
//    }
//	return ret;
//}

@end
