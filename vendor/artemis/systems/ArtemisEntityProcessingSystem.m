#import "ArtemisEntityProcessingSystem.h"

@implementation ArtemisEntityProcessingSystem

+(ArtemisEntityProcessingSystem *)entityProcessingSystemWithAspect:(ArtemisAspect *)aspect
{
	ArtemisEntityProcessingSystem* newValue = [[ArtemisEntityProcessingSystem alloc] initWithAspect:aspect];
	
	return newValue;
}

- (id)initWithAspect:(ArtemisAspect*) aspect
{
    self = [super initWithAspect:aspect];
    if (self) {
		
    }
    return self;
}

-(void) process:(ArtemisEntity*) entity
{
	// subclasses to override
}

-(void)processEntities:(OFObject<ArtemisImmutableBag> *)entities
{
	for (int i = 0, s = entities.size; s > i; i++) {
		[self process:(ArtemisEntity*)[entities get:i]];
	}
}


-(bool)checkProcessing
{
	return true;
}

@end
