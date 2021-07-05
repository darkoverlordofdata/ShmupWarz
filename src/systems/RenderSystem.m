#import "systems/RenderSystem.h"
#import "Components.h"

// #import "ArtemisComponentMapper.h"

@interface RenderSystem()
@property(nonatomic,retain) ArtemisComponentMapper* transformMapper;
@property(nonatomic,retain) ArtemisComponentMapper* identityMapper;
@end

@implementation RenderSystem

+(RenderSystem *)renderSystem
{
	RenderSystem* m = [[RenderSystem alloc] initWithAspect:[ArtemisAspect aspectForAll:@[ [Transform class] ]]];
	
	return m;
}

-(void)initialize
{
    OFLog(@"RenderSystem::initialize");
	self.transformMapper = [ArtemisComponentMapper componentMapperForType:[Transform class] inWorld:self.world];
	self.identityMapper = [ArtemisComponentMapper componentMapperForType:[Identity class] inWorld:self.world];
}

-(void)draw:(ArtemisEntity *)entity
{
	OFLog(@"RenderSystem %@", entity);
	Transform* transform = (Transform*) [self.transformMapper get:entity];
    Identity* identity = (Identity*) [self.identityMapper get:entity];

}

@end
