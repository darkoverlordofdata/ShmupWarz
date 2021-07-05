#import "systems/PhysicsSystem.h"
#import "Components.h"

// #import "ArtemisComponentMapper.h"

@interface PhysicsSystem()
@property(nonatomic,retain) ArtemisComponentMapper* transformMapper;
@property(nonatomic,retain) ArtemisComponentMapper* velocityMapper;
@end

@implementation PhysicsSystem

+(PhysicsSystem *)physicsSystem
{
    OFLog(@"PhysicsSystem::initialize");
	PhysicsSystem* m = [[PhysicsSystem alloc] initWithAspect:[ArtemisAspect aspectForAll:@[ [Transform class], [Velocity class] ]]];
	
	return m;
}

-(void)initialize
{
	self.transformMapper = [ArtemisComponentMapper componentMapperForType:[Transform class] inWorld:self.world];
	self.velocityMapper = [ArtemisComponentMapper componentMapperForType:[Velocity class] inWorld:self.world];
}

-(void)process:(ArtemisEntity *)entity
{
    // OFLog(@"PhysicsSystem::process");
	Transform* transform = (Transform*) [self.transformMapper get:entity];
	Velocity* velocity = (Velocity*) [self.velocityMapper get:entity];

	transform.Pos.X += velocity.X * Shmupwarz.Instance.Delta;
	transform.Pos.Y += velocity.Y * Shmupwarz.Instance.Delta;

}

@end
