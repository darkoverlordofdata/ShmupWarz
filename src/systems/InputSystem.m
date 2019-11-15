#import "systems/InputSystem.h"
#import "Components.h"

// #import "ArtemisComponentMapper.h"

@interface InputSystem()
@property(nonatomic,retain) ArtemisComponentMapper* playerMapper;
@property(nonatomic,retain) ArtemisComponentMapper* transformMapper;
@end

@implementation InputSystem

+(InputSystem *)inputSystem
{
	InputSystem* m = [[InputSystem alloc] initWithAspect:[ArtemisAspect aspectForAll:@[ [Player class], [Transform class] ]]];
	
	return m;
}

-(void)initialize
{
	self.playerMapper = [ArtemisComponentMapper componentMapperForType:[Player class] inWorld:self.world];
	self.transformMapper = [ArtemisComponentMapper componentMapperForType:[Transform class] inWorld:self.world];
}

-(void)process:(ArtemisEntity *)entity
{
	Transform* transform = (Transform*) [self.transformMapper get:entity];
	Player* player = (Player*) [self.playerMapper get:entity];

    // transform.Pos.X = mGame.MouseX;
    // transform.Pos.Y = mGame.MouseY;
    // if ([mGame GetKey:SDL_SCANCODE_Z] || mGame.MouseDown) {
    //     mTimeToFire -= mGame.Delta;
    //     if (mTimeToFire < 0.0) {
    //         [mGame.Bullets appendObject: [[Vector2D alloc]
    //             initWithX:transform.Pos.X-27
    //                     Y:transform.Pos.Y+2 ]];
    //         [mGame.Bullets appendObject: [[Vector2D alloc]
    //             initWithX:transform.Pos.X+27
    //                     Y:transform.Pos.Y+2 ]];
    //         mTimeToFire = FireRate;
    //     }
    // }
}

@end
