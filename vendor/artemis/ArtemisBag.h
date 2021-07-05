/**
 http://code.google.com/p/artemis-framework/source/browse/src/com/artemis/utils/Bag.java
 
 Implements ImmutableBag protocol so that it CAN BE an immutable AS WELL AS a mutable
 */
#import <Foundation/Foundation.h>

#import "ArtemisImmutableBag.h"

@interface ArtemisBag : OFObject <ArtemisImmutableBag>


+(ArtemisBag*) bag;

-(id)initWithCapacity:(OFInteger) c;

-(OFObject*) remove:(OFUInteger) index;
-(OFObject*) removeLast;
/** Have to rename method, Objc doesn't support overloading, it's too basic/weak a language */
-(BOOL) removeFirst:(id) item;

-(BOOL) contains:(id) item;

-(BOOL) removeAll:(ArtemisBag*) otherBag;

-(OFObject*) get:(OFUInteger) index;

@property(nonatomic,readonly) OFUInteger size, capacity;

-(BOOL) isIndexWithinBounds:(OFUInteger) bounds;

@property(nonatomic,readonly) BOOL isEmpty;

-(void) add:(OFObject*) item;

/** Have to rename for objc */
-(void) setItem:(OFObject*) item atIndex:(OFUInteger) index;

-(void) ensureCapacity:(OFUInteger) index;

-(void) clear;

-(void) addAll:(ArtemisBag*) otherBag;

@end
