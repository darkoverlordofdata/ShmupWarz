/**
 http://code.google.com/p/artemis-framework/source/browse/src/com/artemis/utils/ImmutableBag.java
 https://github.com/darkoverlordofdata/artemis-framework/blob/master/src/com/artemis/utils/ImmutableBag.java

 ObjC: preferably, this would be ArtemisBag, and ArtemisBag would be ArtemisMutableBag - but nevermind
 */
#import <Foundation/Foundation.h>

@protocol ArtemisImmutableBag <NSObject>

-(NSObject*) get:(NSUInteger) index;

-(NSUInteger)size;

-(BOOL) isEmpty;

-(BOOL) contains:(id) item;

@end
