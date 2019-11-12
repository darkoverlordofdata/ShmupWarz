/**
 http://code.google.com/p/artemis-framework/source/browse/src/com/artemis/Aspect.java
 
 BUG IN Artemis main: it names the parameters "types" when they are NOT types, but "component class-objects"
 */
#import <Foundation/Foundation.h>

#import "ArtemisBitSet.h"

@interface ArtemisAspect : OFObject
{
    ArtemisBitSet* mAllSet, * mExclusionSet, * mOneSet;
};

@property(nonatomic,retain) ArtemisBitSet* AllSet, * ExclusionSet, * OneSet;

+(ArtemisAspect*) AspectEmpty;

-(ArtemisAspect*) All:(OFArray*) componentClasses;
-(ArtemisAspect*) Exclude:(OFArray*) componentClasses;
-(ArtemisAspect*) One:(OFArray*) componentClasses;

+(ArtemisAspect*) AspectFor:(OFArray*) componentClasses;
+(ArtemisAspect*) AspectForAll:(OFArray*) componentClasses;

+(ArtemisAspect*) AspectForOne:(OFArray*) componentClasses;

@end
