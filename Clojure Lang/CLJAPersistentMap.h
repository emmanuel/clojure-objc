//
//  CLJAPersistentMap.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLJAFn.h"
#import "CLJIPersistentMap.h"

// TODO: conform to an implement NSFastEnumeration
// TODO: conform to an implement NSCoding
@interface CLJAPersistentMap : CLJAFn <CLJIPersistentMap, NSCoding>

@end


//public class PersistentHashMap extends APersistentMap implements IEditableCollection, IObj {
//    
//    
//    final public static PersistentHashMap EMPTY = new PersistentHashMap(0, null, false, null);
//    final private static Object NOT_FOUND = new Object();
//    
//    static public IPersistentMap create(Map other){
//        ITransientMap ret = EMPTY.asTransient();
//        for(Object o : other.entrySet())
//		{
//            Map.Entry e = (Entry) o;
//            ret = ret.assoc(e.getKey(), e.getValue());
//		}
//        return ret.persistent();
//    }
//    
//    /*
//     * @param init {key1,val1,key2,val2,...}
//     */
//    public static PersistentHashMap create(Object... init){
//        ITransientMap ret = EMPTY.asTransient();
//        for(int i = 0; i < init.length; i += 2)
//		{
//            ret = ret.assoc(init[i], init[i + 1]);
//		}
//        return (PersistentHashMap) ret.persistent();
//    }
//    
//    public static PersistentHashMap createWithCheck(Object... init){
//        ITransientMap ret = EMPTY.asTransient();
//        for(int i = 0; i < init.length; i += 2)
//		{
//            ret = ret.assoc(init[i], init[i + 1]);
//            if(ret.count() != i/2 + 1)
//                throw new IllegalArgumentException("Duplicate key: " + init[i]);
//		}
//        return (PersistentHashMap) ret.persistent();
//    }
//    
//    static public PersistentHashMap create(ISeq items){
//        ITransientMap ret = EMPTY.asTransient();
//        for(; items != null; items = items.next().next())
//		{
//            if(items.next() == null)
//                throw new IllegalArgumentException(String.format("No value supplied for key: %s", items.first()));
//            ret = ret.assoc(items.first(), RT.second(items));
//		}
//        return (PersistentHashMap) ret.persistent();
//    }
//    
//    static public PersistentHashMap createWithCheck(ISeq items){
//        ITransientMap ret = EMPTY.asTransient();
//        for(int i=0; items != null; items = items.next().next(), ++i)
//		{
//            if(items.next() == null)
//                throw new IllegalArgumentException(String.format("No value supplied for key: %s", items.first()));
//            ret = ret.assoc(items.first(), RT.second(items));
//            if(ret.count() != i + 1)
//                throw new IllegalArgumentException("Duplicate key: " + items.first());
//		}
//        return (PersistentHashMap) ret.persistent();
//    }
//    
//    /*
//     * @param init {key1,val1,key2,val2,...}
//     */
//    public static PersistentHashMap create(IPersistentMap meta, Object... init){
//        return create(init).withMeta(meta);
//    }
//    
//    PersistentHashMap(int count, INode root, boolean hasNull, Object nullValue){
//        this.count = count;
//        this.root = root;
//        this.hasNull = hasNull;
//        this.nullValue = nullValue;
//        this._meta = null;
//    }
//    
//    public PersistentHashMap(IPersistentMap meta, int count, INode root, boolean hasNull, Object nullValue){
//        this._meta = meta;
//        this.count = count;
//        this.root = root;
//        this.hasNull = hasNull;
//        this.nullValue = nullValue;
//    }
//    
