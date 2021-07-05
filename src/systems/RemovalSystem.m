#import "systems/RemovalSystem.h"
#import "Components.h"

// #import "ArtemisComponentMapper.h"

@interface RemovalSystem()
@property(nonatomic,retain) ArtemisComponentMapper* transformMapper;
@property(nonatomic,retain) ArtemisComponentMapper* timerMapper;
@end

@implementation RemovalSystem

+(RemovalSystem *)removalSystem
{
    NSLog(@"RemovalSystem::initialize");
	RemovalSystem* m = [[RemovalSystem alloc] initWithAspect:[ArtemisAspect aspectForAll:@[ [Transform class] ]]];
	
	return m;
}

-(void)initialize
{
	self.transformMapper = [ArtemisComponentMapper componentMapperForType:[Transform class] inWorld:self.world];
	self.timerMapper = [ArtemisComponentMapper componentMapperForType:[Timer class] inWorld:self.world];
}

-(void)process:(ArtemisEntity *)entity
{
    // NSLog(@"RemovalSystem::process");
	Transform* transform = (Transform*) [self.transformMapper get:entity];
	Timer* expires = (Timer*) [self.timerMapper get:entity];

	let exp = expires.Ms - Shmupwarz.Instance.Delta;
	expires.Ms = exp;
	if (expires.Ms < 0) {
		// [entity disable];
		[entity deleteFromWorld];
        NSLog(@"deleteFromWorld %@ %d", entity, entity.isActive);
	}

}


@end
