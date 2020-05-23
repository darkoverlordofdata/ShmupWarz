/**
 http://code.google.com/p/artemis-framework/source/browse/src/com/artemis/utils/Bag.java
 
 Implements ImmutableBag protocol so that it CAN BE an immutable AS WELL AS a mutable
 */
#import <XCore.h>

#import "ArtemisImmutableBag.h"

@interface ArtemisBag : NSObject <ArtemisImmutableBag>


+(ArtemisBag*) bag;

-(id)initWithCapacity:(NSInteger) c;

-(NSObject*) remove:(NSUInteger) index;
-(NSObject*) removeLast;
/** Have to rename method, Objc doesn't support overloading, it's too basic/weak a language */
-(bool) removeFirst:(id) item;

-(bool) contains:(id) item;

-(bool) removeAll:(ArtemisBag*) otherBag;

-(NSObject*) get:(NSUInteger) index;

@property(nonatomic,readonly) NSUInteger size, capacity;

-(bool) isIndexWithinBounds:(NSUInteger) bounds;

@property(nonatomic,readonly) bool isEmpty;

-(void) add:(NSObject*) item;

/** Have to rename for objc */
-(void) setItem:(NSObject*) item atIndex:(NSUInteger) index;

-(void) ensureCapacity:(NSUInteger) index;

-(void) clear;

-(void) addAll:(ArtemisBag*) otherBag;

@end
