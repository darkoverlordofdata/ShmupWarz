//Copyright 2013 Tomer Shiri generics@shiri.info
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICEOFE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIOOF OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

#if OF_BLOCKS_AVAILABLE
#define GENERICSABLE(__className) \
GENERICSABLEWITHOUTBLOCKS(__className) \
GENERICSABLEWITHBLOCKS(__className)
#else
#define GENERICSABLE(__className) GENERICSABLEWITHOUTBLOCKS(__className)
#endif

#define GENERICSABLEWITHOUTBLOCKS(__className)\
@protocol __className <OFObject> \
@end \
@class __className;  \
typedef OFComparisonResult (^__className##Comparator)(__className* obj1, __className* obj2);  \
\
@interface OFEnumerator (__className##_OFEnumerator_Generics) <__className>  \
- (__className*)nextObject;  \
- (OFArray<__className>*)allObjects; \
@end  \
\
@interface OFArray (__className##_OFArray_Generics) <__className> \
\
- (__className*)objectAtIndex:(OFUInteger)index; \
- (OFArray<__className>*)arrayByAddingObject:(__className*)anObject; \
- (OFArray*)arrayByAddingObjectsFromArray:(OFArray<__className>*)otherArray; \
- (BOOL)containsObject:(__className*)anObject; \
- (__className*)firstObjectCommonWithArray:(OFArray<__className>*)otherArray; \
- (OFUInteger)indexOfObject:(__className*)anObject; \
- (OFUInteger)indexOfObject:(__className*)anObject inRange:(OFRange)range; \
- (OFUInteger)indexOfObjectIdenticalTo:(__className*)anObject; \
- (OFUInteger)indexOfObjectIdenticalTo:(__className*)anObject inRange:(OFRange)range; \
- (BOOL)isEqualToArray:(OFArray<__className>*)otherArray; \
- (__className*)lastObject; \
- (OFEnumerator<__className>*)objectEnumerator; \
- (OFEnumerator<__className>*)reverseObjectEnumerator; \
- (OFArray<__className>*)sortedArrayUsingFunction:(OFInteger (*)(__className*, __className*, void *))comparator context:(void *)context; \
- (OFArray<__className>*)sortedArrayUsingFunction:(OFInteger (*)(__className*, __className*, void *))comparator context:(void *)context hint:(OFData *)hint; \
- (OFArray<__className>*)sortedArrayUsingSelector:(SEL)comparator; \
- (OFArray<__className>*)subarrayWithRange:(OFRange)range; \
- (OFArray<__className>*)objectsAtIndexes:(OFIndexSet *)indexes; \
- (__className*)objectAtIndexedSubscript:(OFUInteger)idx OF_AVAILABLE(10_8, 6_0); \
\
+ (OFArray<__className>*)array; \
+ (OFArray<__className>*)arrayWithObject:(__className*)anObject; \
+ (OFArray<__className>*)arrayWithObjects:(const id [])objects count:(OFUInteger)cnt; \
+ (OFArray<__className>*)arrayWithObjects:(__className*)firstObj, ... OF_REQUIRES_NIL_TERMINATION; \
+ (OFArray<__className>*)arrayWithArray:(OFArray<__className>*)array; \
\
- (OFArray<__className>*)initWithObjects:(const id [])objects count:(OFUInteger)cnt; \
- (OFArray<__className>*)initWithObjects:(id)firstObj, ... OF_REQUIRES_NIL_TERMINATION; \
- (OFArray<__className>*)initWithArray:(OFArray *)array; \
- (OFArray<__className>*)initWithArray:(OFArray *)array copyItems:(BOOL)flag; \
\
+ (OFArray<__className>*)arrayWithContentsOfFile:(OFString *)path; \
+ (OFArray<__className>*)arrayWithContentsOfURL:(OFURL *)url; \
- (OFArray<__className>*)initWithContentsOfFile:(OFString *)path; \
- (OFArray<__className>*)initWithContentsOfURL:(OFURL *)url; \
\
@end \
\
@interface OFMutableArray (__className##_OFMutableArray_Generics) <__className> \
\
- (void)addObjectsFromArray:(OFArray<__className>*)otherArray; \
- (void)removeObject:(__className*)anObject inRange:(OFRange)range; \
- (void)removeObject:(__className*)anObject; \
- (void)removeObjectIdenticalTo:(__className*)anObject inRange:(OFRange)range; \
- (void)removeObjectIdenticalTo:(__className*)anObject; \
- (void)removeObjectsInArray:(OFArray<__className>*)otherArray; \
\
- (void)replaceObjectsInRange:(OFRange)range withObjectsFromArray:(OFArray<__className>*)otherArray range:(OFRange)otherRange; \
- (void)replaceObjectsInRange:(OFRange)range withObjectsFromArray:(OFArray<__className>*)otherArray; \
- (void)setArray:(OFArray<__className>*)otherArray; \
- (void)sortUsingFunction:(OFInteger (*)(__className*, __className*, void *))compare context:(void *)context; \
\
- (void)insertObjects:(OFArray<__className>*)objects atIndexes:(OFIndexSet *)indexes; \
- (void)removeObjectsAtIndexes:(OFIndexSet *)indexes; \
- (void)replaceObjectsAtIndexes:(OFIndexSet *)indexes withObjects:(OFArray<__className>*)objects; \
\
- (void)setObject:(__className*)obj atIndexedSubscript:(OFUInteger)idx OF_AVAILABLE(10_8, 6_0); \
\
+ (OFMutableArray<__className>*)array; \
+ (OFMutableArray<__className>*)arrayWithObject:(__className*)anObject; \
+ (OFMutableArray<__className>*)arrayWithObjects:(const id [])objects count:(OFUInteger)cnt; \
+ (OFMutableArray<__className>*)arrayWithObjects:(__className*)firstObj, ... OF_REQUIRES_NIL_TERMINATION; \
+ (OFMutableArray<__className>*)arrayWithArray:(OFArray<__className>*)array; \
\
- (OFMutableArray<__className>*)initWithObjects:(const id [])objects count:(OFUInteger)cnt; \
- (OFMutableArray<__className>*)initWithObjects:(id)firstObj, ... OF_REQUIRES_NIL_TERMINATION; \
- (OFMutableArray<__className>*)initWithArray:(OFArray *)array; \
- (OFMutableArray<__className>*)initWithArray:(OFArray *)array copyItems:(BOOL)flag; \
\
+ (OFMutableArray<__className>*)arrayWithContentsOfFile:(OFString *)path; \
+ (OFMutableArray<__className>*)arrayWithContentsOfURL:(OFURL *)url; \
- (OFMutableArray<__className>*)initWithContentsOfFile:(OFString *)path; \
- (OFMutableArray<__className>*)initWithContentsOfURL:(OFURL *)url; \
\
@end \
\
@interface OFSet (__className##_OFSet_Generics) <__className> \
\
- (__className*)member:(__className*)object; \
- (OFEnumerator<__className>*)objectEnumerator; \
\
- (OFArray<__className>*)allObjects; \
- (__className*)anyObject; \
- (BOOL)containsObject:(__className*)anObject; \
- (BOOL)intersectsSet:(OFSet<__className>*)otherSet; \
- (BOOL)isEqualToSet:(OFSet<__className>*)otherSet; \
- (BOOL)isSubsetOfSet:(OFSet<__className>*)otherSet; \
\
- (OFSet<__className>*)setByAddingObject:(__className*)anObject OF_AVAILABLE(10_5, 2_0); \
- (OFSet<__className>*)setByAddingObjectsFromSet:(OFSet<__className>*)other OF_AVAILABLE(10_5, 2_0); \
- (OFSet<__className>*)setByAddingObjectsFromArray:(OFArray *)other OF_AVAILABLE(10_5, 2_0); \
\
+ (OFSet<__className>*)set; \
+ (OFSet<__className>*)setWithObject:(__className*)object; \
+ (OFSet<__className>*)setWithObjects:(const id [])objects count:(OFUInteger)cnt; \
+ (OFSet<__className>*)setWithObjects:(__className*)firstObj, ... OF_REQUIRES_NIL_TERMINATION; \
+ (OFSet<__className>*)setWithSet:(OFSet<__className>*)set; \
+ (OFSet<__className>*)setWithArray:(OFArray<__className>*)array; \
\
- (OFSet<__className>*)initWithObjects:(const id [])objects count:(OFUInteger)cnt; \
- (OFSet<__className>*)initWithObjects:(__className*)firstObj, ... OF_REQUIRES_NIL_TERMINATION; \
- (OFSet<__className>*)initWithSet:(OFSet<__className>*)set; \
- (OFSet<__className>*)initWithSet:(OFSet<__className>*)set copyItems:(BOOL)flag; \
- (OFSet<__className>*)initWithArray:(OFArray<__className>*)array; \
\
@end \
\
@interface OFMutableSet (__className##_OFMutableSet_Generics) <__className> \
\
- (void)addObject:(__className*)object; \
- (void)removeObject:(__className*)object; \
- (void)addObjectsFromArray:(OFArray<__className>*)array; \
- (void)intersectSet:(OFSet<__className>*)otherSet; \
- (void)minusSet:(OFSet<__className>*)otherSet; \
- (void)unionSet:(OFSet<__className>*)otherSet; \
\
- (void)setSet:(OFSet<__className>*)otherSet; \
+ (OFSet<__className>*)setWithCapacity:(OFUInteger)numItems; \
- (OFSet<__className>*)initWithCapacity:(OFUInteger)numItems; \
\
@end \
\
@interface OFCountedSet (__className##_OFCountedSet_Generics) <__className> \
\
- (OFSet<__className>*)initWithCapacity:(OFUInteger)numItems;  \
- (OFSet<__className>*)initWithArray:(OFArray<__className>*)array; \
- (OFSet<__className>*)initWithSet:(OFSet<__className>*)set; \
- (OFUInteger)countForObject:(__className*)object; \
- (OFEnumerator<__className>*)objectEnumerator; \
- (void)addObject:(__className*)object; \
- (void)removeObject:(__className*)object; \
\
@end \

#if OF_BLOCKS_AVAILABLE

#define GENERICSABLEWITHBLOCKS(__className) \
\
@interface OFMutableArray (__className##_OFMutableArray_BLOCKS_Generics) <__className> \
- (void)sortUsingComparator:(__className##Comparator)cmptr OF_AVAILABLE(10_6, 4_0); \
- (void)sortWithOptions:(OFSortOptions)opts usingComparator:(__className##Comparator)cmptr OF_AVAILABLE(10_6, 4_0); \
@end \
@interface OFSet (__className##_OFSet_BLOCKS_Generics) <__className> \
- (void)enumerateObjectsUsingBlock:(void (^)(__className* obj, BOOL *stop))block OF_AVAILABLE(10_6, 4_0); \
- (void)enumerateObjectsWithOptions:(OFEnumerationOptions)opts usingBlock:(void (^)(__className* obj, BOOL *stop))block OF_AVAILABLE(10_6, 4_0); \
- (OFSet<__className>*)objectsPassingTest:(BOOL (^)(__className* obj, BOOL *stop))predicate OF_AVAILABLE(10_6, 4_0); \
- (OFSet<__className>*)objectsWithOptions:(OFEnumerationOptions)opts passingTest:(BOOL (^)(__className* obj, BOOL *stop))predicate OF_AVAILABLE(10_6, 4_0); \
@end \

#endif
