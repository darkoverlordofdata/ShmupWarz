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

-(ArtemisAspect*) all:(NSArray*) componentClasses
{
	if( componentClasses.count < 1 )
		NSLog(@"WARNING: you created an Aspect of type ALL with zero elements");
	
	for( Class cClass in componentClasses )
	{
		[self.allSet set:(NSInteger)[ArtemisComponentType getIndexFor:cClass] to:true];
	}
	
	return self;
}

-(ArtemisAspect*) exclude:(NSArray*) componentClasses
{
	if( componentClasses.count < 1 )
		NSLog(@"WARNING: you created an Aspect of type EXCLUDE with zero elements");
	
	for( Class cClass in componentClasses )
	{
		[self.exclusionSet set:(NSInteger)[ArtemisComponentType getIndexFor:cClass] to:true];
	}
	
	return self;
}

-(ArtemisAspect*) one:(NSArray*) componentClasses
{
	if( componentClasses.count < 1 )
		NSLog(@"WARNING: you created an Aspect of type ONE with zero elements");
	
	for( Class cClass in componentClasses )
	{
		[self.oneSet set:(NSInteger)[ArtemisComponentType getIndexFor:cClass] to:true];
	}
	
	return self;
}

+(ArtemisAspect*) aspectFor:(NSArray*) componentClasses
{
	return [self aspectForAll:componentClasses];
}

+(ArtemisAspect*) aspectForAll:(NSArray*) componentClasses
{
	ArtemisAspect* aspect = [ArtemisAspect aspectEmpty];
	
	[aspect all:componentClasses];
	
	return aspect;
}

+(ArtemisAspect*) aspectForOne:(NSArray*) componentClasses
{
	ArtemisAspect* aspect = [ArtemisAspect aspectEmpty];
	
	[aspect one:componentClasses];
	
	return aspect;
}

-(NSString *)description
{
	NSMutableString* s = [NSMutableString string];
	
	[s appendString:@"[Aspect:"];

	[s appendFormat:@" ALL: %@", self.allSet];
	[s appendFormat:@" EXCLUDE: %@", self.exclusionSet];
	[s appendFormat:@" ONE: %@", self.oneSet];
	
	[s appendString:@"]"];
	return s;
}

@end
