//
//  CLJArrayNode.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/24/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <objc/runtime.h>
#import "CLJPersistentHashMapUtils.h"
#import "CLJPersistentHashMapArrayNode.h"
#import "CLJPersistentHashMapBitmapIndexNode.h"


@interface CLJPersistentHashMapArrayNode ()

@property (atomic) NSThread *editThread;
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSPointerArray *array;

- (void)removeAllObjects;

@end



@implementation CLJPersistentHashMapArrayNode

+ (instancetype)nodeWithEditThread:(NSThread *)editThread count:(NSUInteger)count array:(NSPointerArray *)array
{
    return [[self alloc] initWithEditThread:editThread count:count array:array];
}

- (instancetype)initWithEditThread:(NSThread *)editThread count:(NSUInteger)count array:(NSPointerArray *)array
{
    NSParameterAssert(array);
    
    if (self = [super init])
    {
        _editThread = editThread;
        _count = count;
        _array = array;
    }
    
    return self;
}

#pragma mark - CLJIPersistentHashMapNode

/**
 * Return a new node that associates `key` with `object`. 
 * Called recursively, returns node at head of a path of nodes,
 * from the layer designated by shift, down as far into the tree as needed.
 *
 * @param key An object whose hash value determines uniqueness
 * @param object An object to be associated with key
 * @param shift An integer multiple of 5 that describes how many levels into the tree should be searched
 * @return Hash map node at the head of a path of nodes that traverse from root (returned) to inserted
 */
- (id<CLJIPersistentHashMapNode>)assocKey:(id)key withObject:(id)object shift:(NSUInteger)shift hash:(NSUInteger)hash addedLeaf:(BOOL *)addedLeaf
{
    NSUInteger index = CLJPersistentHashMapUtil_mask(hash, shift);
    id<CLJIPersistentHashMapNode> node = (id<CLJIPersistentHashMapNode>)[self.array pointerAtIndex:index];

    if (nil == node)
    {
        id<CLJIPersistentHashMapNode> bitmapIndexNode = [[CLJPersistentHashMapBitmapIndexNode empty] assocKey:key withObject:object shift:shift + 5 hash:hash addedLeaf:addedLeaf];
        NSPointerArray *newArray = [self.array copy];
        [newArray replacePointerAtIndex:index withPointer:(__bridge void *)bitmapIndexNode];
        return [CLJPersistentHashMapArrayNode nodeWithEditThread:nil count:_count + 1 array:newArray];
    }

    id<CLJIPersistentHashMapNode> newNode = [node assocKey:key withObject:object shift:shift + 5 hash:hash addedLeaf:addedLeaf];
    if (newNode == node) return self;

    NSPointerArray *newArray = [self.array copy];
    [newArray replacePointerAtIndex:index withPointer:(__bridge void *)newNode];
    return [CLJPersistentHashMapArrayNode nodeWithEditThread:nil count:_count array:newArray];
}

- (id<CLJIPersistentHashMapNode>)withoutKey:(id)key withShift:(NSUInteger)shift hash:(NSUInteger)hash
{
    NSUInteger index = CLJPersistentHashMapUtil_mask(hash, shift);
    // id<CLJIPersistentHashMapNode> node = (__bridge id<CLJIPersistentHashMapNode>)_array[index];
    id<CLJIPersistentHashMapNode> node = (__bridge id)[self.array pointerAtIndex:index];
    if (nil == node) return self;
    id<CLJIPersistentHashMapNode> newNode = [node withoutKey:key withShift:shift + 5 hash:hash];
    if (newNode == node) return self;
    if (nil == newNode)
    {
        if (self.count <= 8) return [self packWithEditThread:nil index:index];
        NSPointerArray *newArray = [self.array copy];
        [newArray replacePointerAtIndex:index withPointer:(__bridge void *)newNode];
        return [CLJPersistentHashMapArrayNode nodeWithEditThread:nil count:_count - 1 array:newArray];
    }
    else
    {
        NSPointerArray *newArray = [self.array copy];
        [newArray replacePointerAtIndex:index withPointer:(__bridge void *)newNode];
        return [CLJPersistentHashMapArrayNode nodeWithEditThread:nil count:_count array:newArray];
    }
}

- (id<CLJIMapEntry>)findKey:(id)key withShift:(NSUInteger)shift hash:(NSUInteger)hash
{
    NSUInteger index = CLJPersistentHashMapUtil_mask(hash, shift);
    id<CLJIPersistentHashMapNode> node = (__bridge id)[self.array pointerAtIndex:index];
    if (nil == node) return nil;
    return [node findKey:key withShift:shift + 5 hash:hash];
}

- (id)findKey:(id)key withShift:(NSUInteger)shift hash:(NSUInteger)hash notFound:(id)notFound
{
    return [self findKey:key withShift:shift hash:hash] ?: notFound;
}

#pragma mark - Internal/Private methods

- (id<CLJIPersistentHashMapNode>)packWithEditThread:(NSThread *)editThread index:(NSUInteger)index
{
    NSUInteger count = self.count;
    NSPointerArray *array = self.array;
    NSPointerArray *newArray = [NSPointerArray strongObjectsPointerArray];
    [newArray setCount:2 * (count - 1)];
    NSUInteger j = 1;
    NSUInteger bitmap = 0;

    for (NSUInteger i = 0; i < index; i++)
    {
        id object = [array pointerAtIndex:i];
        if (nil != object)
        {
            [newArray replacePointerAtIndex:j withPointer:(__bridge void *)object];
            bitmap |= 1 << i;
            j += 2;
        }
    }

    for (NSUInteger i = index + 1; i < count; i++)
    {
        id object = [array pointerAtIndex:i];
        if (nil != object)
        {
            [newArray replacePointerAtIndex:j withPointer:(__bridge void *)object];
            bitmap |= 1 << i;
            j += 2;
        }
    }

    return [CLJPersistentHashMapBitmapIndexNode nodeWithEditThread:editThread bitmap:bitmap array:newArray];
}

@end

//final static class ArrayNode implements INode{
//	int count;
//	final INode[] array;
//	final AtomicReference<Thread> edit;
//    
//	ArrayNode(AtomicReference<Thread> edit, int count, INode[] array){
//		this.array = array;
//		this.edit = edit;
//		this.count = count;
//	}
//    
//	public INode assoc(int shift, int hash, Object key, Object val, Box addedLeaf){
//		int idx = mask(hash, shift);
//		INode node = array[idx];
//		if(node == null)
//			return new ArrayNode(null, count + 1, cloneAndSet(array, idx, BitmapIndexedNode.EMPTY.assoc(shift + 5, hash, key, val, addedLeaf)));
//		INode n = node.assoc(shift + 5, hash, key, val, addedLeaf);
//		if(n == node)
//			return this;
//		return new ArrayNode(null, count, cloneAndSet(array, idx, n));
//	}
//    
//	public INode without(int shift, int hash, Object key){
//		int idx = mask(hash, shift);
//		INode node = array[idx];
//		if(node == null)
//			return this;
//		INode n = node.without(shift + 5, hash, key);
//		if(n == node)
//			return this;
//		if (n == null) {
//			if (count <= 8) // shrink
//				return pack(null, idx);
//			return new ArrayNode(null, count - 1, cloneAndSet(array, idx, n));
//		} else
//			return new ArrayNode(null, count, cloneAndSet(array, idx, n));
//	}
//    
//	public IMapEntry find(int shift, int hash, Object key){
//		int idx = mask(hash, shift);
//		INode node = array[idx];
//		if(node == null)
//			return null;
//		return node.find(shift + 5, hash, key);
//	}
//    
//	public Object find(int shift, int hash, Object key, Object notFound){
//		int idx = mask(hash, shift);
//		INode node = array[idx];
//		if(node == null)
//			return notFound;
//		return node.find(shift + 5, hash, key, notFound);
//	}
//	
//	public ISeq nodeSeq(){
//		return Seq.create(array);
//	}
//    
//    public Object kvreduce(IFn f, Object init){
//        for(INode node : array){
//            if(node != null){
//                init = node.kvreduce(f,init);
//	            if(RT.isReduced(init))
//		            return ((IDeref)init).deref();
//            }
//        }
//        return init;
//    }
//    
//	public Object fold(final IFn combinef, final IFn reducef,
//	                   final IFn fjtask, final IFn fjfork, final IFn fjjoin){
//		List<Callable> tasks = new ArrayList();
//		for(final INode node : array){
//			if(node != null){
//				tasks.add(new Callable(){
//					public Object call() throws Exception{
//						return node.fold(combinef, reducef, fjtask, fjfork, fjjoin);
//					}
//				});
//            }
//        }
//        
//		return foldTasks(tasks,combinef,fjtask,fjfork,fjjoin);
//    }
//    
//	static public Object foldTasks(List<Callable> tasks, final IFn combinef,
//                                   final IFn fjtask, final IFn fjfork, final IFn fjjoin){
//        
//		if(tasks.isEmpty())
//			return combinef.invoke();
//        
//		if(tasks.size() == 1){
//			Object ret = null;
//			try
//            {
//				return tasks.get(0).call();
//            }
//			catch(Exception e)
//            {
//				//aargh
//            }
//        }
//        
//		List<Callable> t1 = tasks.subList(0,tasks.size()/2);
//		final List<Callable> t2 = tasks.subList(tasks.size()/2, tasks.size());
//        
//		Object forked = fjfork.invoke(fjtask.invoke(new Callable() {
//			public Object call() throws Exception{
//				return foldTasks(t2,combinef,fjtask,fjfork,fjjoin);
//			}
//		}));
//        
//		return combinef.invoke(foldTasks(t1,combinef,fjtask,fjfork,fjjoin),fjjoin.invoke(forked));
//	}
//    
//    
//	private ArrayNode ensureEditable(AtomicReference<Thread> edit){
//		if(this.edit == edit)
//			return this;
//		return new ArrayNode(edit, count, this.array.clone());
//	}
//	
//	private ArrayNode editAndSet(AtomicReference<Thread> edit, int i, INode n){
//		ArrayNode editable = ensureEditable(edit);
//		editable.array[i] = n;
//		return editable;
//	}
//    
//    
//	private INode pack(AtomicReference<Thread> edit, int idx) {
//		Object[] newArray = new Object[2*(count - 1)];
//		int j = 1;
//		int bitmap = 0;
//		for(int i = 0; i < idx; i++)
//			if (array[i] != null) {
//				newArray[j] = array[i];
//				bitmap |= 1 << i;
//				j += 2;
//			}
//		for(int i = idx + 1; i < array.length; i++)
//			if (array[i] != null) {
//				newArray[j] = array[i];
//				bitmap |= 1 << i;
//				j += 2;
//			}
//		return new BitmapIndexedNode(edit, bitmap, newArray);
//	}
//    
//	public INode assoc(AtomicReference<Thread> edit, int shift, int hash, Object key, Object val, Box addedLeaf){
//		int idx = mask(hash, shift);
//		INode node = array[idx];
//		if(node == null) {
//			ArrayNode editable = editAndSet(edit, idx, BitmapIndexedNode.EMPTY.assoc(edit, shift + 5, hash, key, val, addedLeaf));
//			editable.count++;
//			return editable;
//		}
//		INode n = node.assoc(edit, shift + 5, hash, key, val, addedLeaf);
//		if(n == node)
//			return this;
//		return editAndSet(edit, idx, n);
//	}
//    
//	public INode without(AtomicReference<Thread> edit, int shift, int hash, Object key, Box removedLeaf){
//		int idx = mask(hash, shift);
//		INode node = array[idx];
//		if(node == null)
//			return this;
//		INode n = node.without(edit, shift + 5, hash, key, removedLeaf);
//		if(n == node)
//			return this;
//		if(n == null) {
//			if (count <= 8) // shrink
//				return pack(edit, idx);
//			ArrayNode editable = editAndSet(edit, idx, n);
//			editable.count--;
//			return editable;
//		}
//		return editAndSet(edit, idx, n);
//	}
//	
//	static class Seq extends ASeq {
//		final INode[] nodes;
//		final int i;
//		final ISeq s;
//		
//		static ISeq create(INode[] nodes) {
//			return create(null, nodes, 0, null);
//		}
//		
//		private static ISeq create(IPersistentMap meta, INode[] nodes, int i, ISeq s) {
//			if (s != null)
//				return new Seq(meta, nodes, i, s);
//			for(int j = i; j < nodes.length; j++)
//				if (nodes[j] != null) {
//					ISeq ns = nodes[j].nodeSeq();
//					if (ns != null)
//						return new Seq(meta, nodes, j + 1, ns);
//				}
//			return null;
//		}
//		
//		private Seq(IPersistentMap meta, INode[] nodes, int i, ISeq s) {
//			super(meta);
//			this.nodes = nodes;
//			this.i = i;
//			this.s = s;
//		}
//        
//		public Obj withMeta(IPersistentMap meta) {
//			return new Seq(meta, nodes, i, s);
//		}
//        
//		public Object first() {
//			return s.first();
//		}
//        
//		public ISeq next() {
//			return create(null, nodes, i, s.next());
//		}
//		
//	}
//}
