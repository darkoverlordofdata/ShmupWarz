#import "systems/PhysicsSystem.h"
#import "Components.h"

// #import "ArtemisComponentMapper.h"

@interface PhysicsSystem()
@property(nonatomic,retain) ArtemisComponentMapper* transformMapper;
@end

@implementation PhysicsSystem

+(PhysicsSystem *)physicsSystem
{
	PhysicsSystem* m = [[PhysicsSystem alloc] initWithAspect:[ArtemisAspect aspectForAll:@[ [Transform class] ]]];
	
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
