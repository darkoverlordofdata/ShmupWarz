#import "systems/SpawnSystem.h"
#import "Components.h"

// #import "ArtemisComponentMapper.h"

@interface SpawnSystem()
@property(nonatomic,retain) ArtemisComponentMapper* transformMapper;
@end

@implementation SpawnSystem

+(SpawnSystem *)spawnSystem
{
	SpawnSystem* m = [[SpawnSystem alloc] initWithAspect:[ArtemisAspect aspectForAll:@[ [Transform class] ]]];
	
	return m;
}

-(void)initialize
{
    OFLog(@"SpawnSystem::initialize");
	self.transformMapper = [ArtemisComponentMapper componentMapperForType:[Transform class] inWorld:self.world];
}

-(void)process:(ArtemisEntity *)entity
{
    // OFLog(@"SpawnSystem::process");
	Transform* transform = (Transform*) [self.transformMapper get:entity];
}

@end
