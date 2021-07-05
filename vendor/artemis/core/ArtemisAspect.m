#import "ArtemisAspect.h"
#import "ArtemisComponentType.h"

@implementation ArtemisAspect
@synthesize allSet = _allSet;
@synthesize exclusionSet = _exclusionSet;
@synthesize oneSet = _oneSet;

- (id)init
{
    self = [super init];
    if (self) {
        self.allSet = [ArtemisBitSet new];
		self.exclusionSet = [ArtemisBitSet new];
		self.oneSet = [ArtemisBitSet new];
    }
    return self;
}

+(ArtemisAspect*) aspectEmpty
{
	ArtemisAspect* newValue = [ArtemisAspect new];
	
	return newValue;
}

-(ArtemisAspect*) all:(OFArray*) componentClasses
{
	if( componentClasses.count < 1 )
		OFLog(@"WARNING: you created an Aspect of type ALL with zero elements");
	
	for( Class cClass in componentClasses )
	{
		[self.allSet set:(OFInteger)[ArtemisComponentType getIndexFor:cClass] to:true];
	}
	
	return self;
}

-(ArtemisAspect*) exclude:(OFArray*) componentClasses
{
	if( componentClasses.count < 1 )
		OFLog(@"WARNING: you created an Aspect of type EXCLUDE with zero elements");
	
	for( Class cClass in componentClasses )
	{
		[self.exclusionSet set:(OFInteger)[ArtemisComponentType getIndexFor:cClass] to:true];
	}
	
	return self;
}

-(ArtemisAspect*) one:(OFArray*) componentClasses
{
	if( componentClasses.count < 1 )
		OFLog(@"WARNING: you created an Aspect of type ONE with zero elements");
	
	for( Class cClass in componentClasses )
	{
		[self.oneSet set:(OFInteger)[ArtemisComponentType getIndexFor:cClass] to:true];
	}
	
	return self;
}

+(ArtemisAspect*) aspectFor:(OFArray*) componentClasses
{
	return [self aspectForAll:componentClasses];
}

+(ArtemisAspect*) aspectForAll:(OFArray*) componentClasses
{
	ArtemisAspect* aspect = [ArtemisAspect aspectEmpty];
	
	[aspect all:componentClasses];
	
	return aspect;
}

+(ArtemisAspect*) aspectForOne:(OFArray*) componentClasses
{
	ArtemisAspect* aspect = [ArtemisAspect aspectEmpty];
	
	[aspect one:componentClasses];
	
	return aspect;
}

-(OFString *)description
{
	OFMutableString* s = [OFMutableString string];
	
	[s appendString:@"[Aspect:"];

	[s appendFormat:@" ALL: %@", self.allSet];
	[s appendFormat:@" EXCLUDE: %@", self.exclusionSet];
	[s appendFormat:@" ONE: %@", self.oneSet];
	
	[s appendString:@"]"];
	return s;
}

@end
