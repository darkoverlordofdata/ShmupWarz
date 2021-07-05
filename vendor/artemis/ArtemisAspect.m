#import "ArtemisAspect.h"
#import "ArtemisComponentType.h"

@implementation ArtemisAspect
@synthesize AllSet = mAllSet;
@synthesize ExclusionSet = mExclusionSet;
@synthesize OneSet = mOneSet;

- (id)init
{
    self = [super init];
    if (self) {
        self.AllSet = [ArtemisBitSet new];
		self.ExclusionSet = [ArtemisBitSet new];
		self.OneSet = [ArtemisBitSet new];
    }
    return self;
}

+(ArtemisAspect*) AspectEmpty
{
	ArtemisAspect* newValue = [ArtemisAspect new];
	
	return newValue;
}

-(ArtemisAspect*) All:(OFArray*) componentClasses
{
	if( componentClasses.count < 1 )
		OFLog(@"WARNING: you created an Aspect of type ALL with zero elements");
	
	for( Class cClass in componentClasses )
	{
		[self.AllSet Set: (OFInteger)[ArtemisComponentType GetIndexFor:cClass] To:true];
	}
	
	return self;
}

-(ArtemisAspect*) Exclude:(OFArray*) componentClasses
{
	if( componentClasses.count < 1 )
		OFLog(@"WARNING: you created an Aspect of type EXCLUDE with zero elements");
	
	for( Class cClass in componentClasses )
	{
		[self.ExclusionSet Set: (OFInteger)[ArtemisComponentType GetIndexFor:cClass] To:true];
	}
	
	return self;
}

-(ArtemisAspect*) One:(OFArray*) componentClasses
{
	if( componentClasses.count < 1 )
		OFLog(@"WARNING: you created an Aspect of type ONE with zero elements");
	
	for( Class cClass in componentClasses )
	{
		[self.OneSet Set: (OFInteger)[ArtemisComponentType GetIndexFor:cClass] To:true];
	}
	
	return self;
}

+(ArtemisAspect*) AspectFor:(OFArray*) componentClasses
{
	return [self AspectForAll:componentClasses];
}

+(ArtemisAspect*) AspectForAll:(OFArray*) componentClasses
{
	ArtemisAspect* aspect = [ArtemisAspect AspectEmpty];
	
	[aspect All:componentClasses];
	
	return aspect;
}

+(ArtemisAspect*) AspectForOne:(OFArray*) componentClasses
{
	ArtemisAspect* aspect = [ArtemisAspect AspectEmpty];
	
	[aspect One:componentClasses];
	
	return aspect;
}

-(OFString *)description
{
	OFMutableString* s = [OFMutableString string];
	
	[s appendString:@"[Aspect:"];

	[s appendFormat:@" ALL: %@", self.AllSet];
	[s appendFormat:@" EXCLUDE: %@", self.ExclusionSet];
	[s appendFormat:@" ONE: %@", self.OneSet];
	
	[s appendString:@"]"];
	return s;
}

@end
