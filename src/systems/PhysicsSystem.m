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
    NSLog(@"PhysicsSystem::initialize");
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
	Transform* transform = (Transform*) [self.transformMapper get:entity];
	Velocity* velocity = (Velocity*) [self.velocityMapper get:entity];
    NSLog(@"PhysicsSystem->process - (%f, %f)",  
		transform.Pos.X, transform.Pos.Y);

	transform.Pos.X += velocity.X * Shmupwarz.Instance.Delta;
	transform.Pos.Y += velocity.Y * Shmupwarz.Instance.Delta;
    NSLog(@"PhysicsSystem->process + (%f, %f)",  
		transform.Pos.X, transform.Pos.Y);

}

@end
