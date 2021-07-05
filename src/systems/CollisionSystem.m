#import "systems/CollisionSystem.h"
#import "Components.h"

// #import "ArtemisComponentMapper.h"

@interface CollisionSystem()
@property(nonatomic,retain) ArtemisComponentMapper* healthMapper;
@property(nonatomic,retain) ArtemisComponentMapper* identityMapper;
@property(nonatomic,retain) ArtemisComponentMapper* transformMapper;
@end

@implementation CollisionSystem

+(CollisionSystem *)collisionSystem
{
	CollisionSystem* m = [[CollisionSystem alloc] initWithAspect:[ArtemisAspect aspectForAll:@[ [Health class], [Transform class], [Identity class] ]]];
	
	return m;
}

-(void)initialize
{
	self.healthMapper = [ArtemisComponentMapper componentMapperForType:[Health class] inWorld:self.world];
	self.identityMapper = [ArtemisComponentMapper componentMapperForType:[Identity class] inWorld:self.world];
	self.transformMapper = [ArtemisComponentMapper componentMapperForType:[Transform class] inWorld:self.world];
}

-(void)process:(ArtemisEntity *)entity
{
	Health* health = (Health*) [self.healthMapper get:entity];
	Identity* identity = (Identity*) [self.identityMapper get:entity];
	Transform* transform = (Transform*) [self.transformMapper get:entity];

    if (entity.isActive && identity.Category == CATEGORY_ENEMY) {

        // for (Entity* bullet in Factory.Health) {
        //     if (bulletisActive && bullet.Identity.Category == CATEGORY_BULLET) {

        //         if (SDL_HasIntersection(entity.Transform.RefBounds, bullet.Transform.RefBounds)) {
        //             if (entityisActive && bulletisActive) [self HandleCollision:entity Other:bullet];
        //             return;
        //         }
        //     }
        // }
    }

}

@end
