#import <XCore.h>
#import <xna/xna.h>
#import <artemis/artemis.h>
#import "Components.h"
#import "Factory.h"
#import "systems/AnimationSystem.h"
#import "systems/CollisionSystem.h"
#import "systems/InputSystem.h"
#import "systems/PhysicsSystem.h"
#import "systems/RemovalSystem.h"
#import "systems/RenderSystem.h"
#import "systems/SpawnSystem.h"

@class Systems;

@interface Shmupwarz : Game 
{
    Entity* mPlayer;
    id mSystems;
    ArtemisWorld* mWorld;
}
@property (nonatomic, readonly, retain) ArtemisWorld* World;
@property (class, nonatomic, retain, readonly) Shmupwarz* Instance;

- (instancetype)initWithWidth:(int)width 
                       Height:(int)height;
- (NSString*)description;
- (void)SetSystem:(Systems*)systems;
- (void)Initialize;
- (void)LoadContent;
- (void)Update:(GLfloat) delta;
- (void)Draw:(GLfloat) delta;
- (Entity*)GetEntity:(int)index;

@end