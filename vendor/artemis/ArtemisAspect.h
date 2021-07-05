/**
 http://code.google.com/p/artemis-framework/source/browse/src/com/artemis/Aspect.java
 
 BUG IN Artemis main: it names the parameters "types" when they are NOT types, but "component class-objects"
 */
#import <Foundation/Foundation.h>

#import "ArtemisBitSet.h"

@interface ArtemisAspect : OFObject
{
    ArtemisBitSet* _allSet, * _exclusionSet, * _oneSet;
};

@property(nonatomic,retain) ArtemisBitSet* allSet, * exclusionSet, * oneSet;

+(ArtemisAspect*) aspectEmpty;

-(ArtemisAspect*) all:(OFArray*) componentClasses;
-(ArtemisAspect*) exclude:(OFArray*) componentClasses;
-(ArtemisAspect*) one:(OFArray*) componentClasses;

+(ArtemisAspect*) aspectFor:(OFArray*) componentClasses;
+(ArtemisAspect*) aspectForAll:(OFArray*) componentClasses;

+(ArtemisAspect*) aspectForOne:(OFArray*) componentClasses;

@end
