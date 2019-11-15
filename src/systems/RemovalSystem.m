#import "systems/RemovalSystem.h"
#import "Components.h"

// #import "ArtemisComponentMapper.h"

@interface RemovalSystem()
@property(nonatomic,retain) ArtemisComponentMapper* transformMapper;
@end

@implementation RemovalSystem

+(RemovalSystem *)removalSystem
{
	RemovalSystem* m = [[RemovalSystem alloc] initWithAspect:[ArtemisAspect aspectForAll:@[ [Transform class] ]]];
	
	return m;
}

-(void)initialize
{
	self.transformMapper = [ArtemisComponentMapper componentMapperForType:[Transform class] inWorld:self.world];
}

-(void)process:(ArtemisEntity *)entity
{
	Transform* transform = (Transform*) [self.transformMapper get:entity];
}

@end
