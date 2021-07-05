/**
 http://code.google.com/p/artemis-framework/source/browse/src/com/artemis/utils/ImmutableBag.java
 
 ObjC: preferably, this would be ArtemisBag, and ArtemisBag would be ArtemisMutableBag - but nevermind
 */
#import <Foundation/Foundation.h>

@protocol ArtemisImmutableBag <OFObject>

-(OFObject*) get:(int) index;

-(int)size;

-(bool) isEmpty;

-(bool) contains:(id) item;

@end
