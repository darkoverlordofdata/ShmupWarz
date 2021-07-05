#import "systems/InputSystem.h"

// #import "ArtemisComponentMapper.h"

@interface InputSystem()
@property(nonatomic,retain) ArtemisComponentMapper* playerMapper;
@property(nonatomic,retain) ArtemisComponentMapper* transformMapper;
@end

@implementation InputSystem

static const double FireRate = 0.1;


+(InputSystem *)inputSystem
{
	InputSystem* m = [[InputSystem alloc] initWithAspect:[ArtemisAspect aspectForAll:@[ [Player class], [Transform class] ]]];
	
	return m;
}

-(void)initialize
{
    OFLog(@"InputSystem::initialize");
	self.playerMapper = [ArtemisComponentMapper componentMapperForType:[Player class] inWorld:self.world];
	self.transformMapper = [ArtemisComponentMapper componentMapperForType:[Transform class] inWorld:self.world];
}

-(void)process:(ArtemisEntity *)entity
{
	Transform* transform = (Transform*) [self.transformMapper get:entity];
	Player* player = (Player*) [self.playerMapper get:entity];

    transform.Pos.X = Shmupwarz.Instance.MouseX;
    transform.Pos.Y = Shmupwarz.Instance.MouseY;
    if ([Shmupwarz.Instance GetKey:SDL_SCANCODE_Z] || Shmupwarz.Instance.MouseDown) {
        mTimeToFire -= Shmupwarz.Instance.Delta;
        if (mTimeToFire < 0.0) {
            [Factory CreateBullet:Shmupwarz.Instance.World X:transform.Pos.X-27 Y:transform.Pos.Y+2];
            [Factory CreateBullet:Shmupwarz.Instance.World X:transform.Pos.X+27 Y:transform.Pos.Y+2];
            mTimeToFire = FireRate;
        }
    }
}

@end
