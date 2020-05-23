#import "systems/AnimationSystem.h"
#import "Components.h"

// #import "ArtemisComponentMapper.h"

@interface AnimationSystem()
@property(nonatomic,retain) ArtemisComponentMapper* tweenMapper;
@property(nonatomic,retain) ArtemisComponentMapper* transformMapper;
@end

@implementation AnimationSystem

+(AnimationSystem *)animationSystem
{
	AnimationSystem* m = [[AnimationSystem alloc] initWithAspect:[ArtemisAspect aspectForAll:@[ [Tween class], [Transform class] ]]];
	
	return m;
}

-(void)initialize
{
    // NSLog(@"AnimationSystem::initialize");
	self.tweenMapper = [ArtemisComponentMapper componentMapperForType:[Tween class] inWorld:self.world];
	self.transformMapper = [ArtemisComponentMapper componentMapperForType:[Transform class] inWorld:self.world];
}

-(void)process:(ArtemisEntity *)entity
{
    NSLog(@"AnimationSystem::process");
	Tween* tween = (Tween*) [self.tweenMapper get:entity];
	Transform* transform = (Transform*) [self.transformMapper get:entity];

    if (entity.isActive && tween) {

        var x = transform.Scale.X + (tween.Speed * self.world.delta);
        var y = transform.Scale.Y + (tween.Speed * self.world.delta);
        var Active = tween.Active;

        if (x > tween.Max) {
            x = tween.Max;
            y = tween.Max;
            Active = false;
        } else if (x < tween.Min) {
            x = tween.Min;
            y = tween.Min;
            Active = false;
        }
        transform.Scale.X = x; 
        transform.Scale.Y = y; 
        [transform 
            X:transform.Pos.X - transform.Bounds.w / 2
            Y:transform.Pos.Y - transform.Bounds.h / 2
            W:transform.Texture.Width * transform.Scale.X
            H:transform.Texture.Height * transform.Scale.Y];

        tween.Active = Active;
    }
}

@end
