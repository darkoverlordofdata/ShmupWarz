#import <Foundation/Foundation.h>
#import <xna/xna.h>
#import <artemis/artemis.h>
#import "Components.h"
#import "Factory.h"
#import "systems/AnimationSystem.h"
#import "systems/CollisionSystem.h"
#import "systems/InputSystem.h"
#import "systems/PhysicsSystem.h"
#import "systems/RemovalSystem.h"
#import "systems/SpawnSystem.h"

@class Systems;

@interface Shmupwarz : Game 
{
    Entity* mPlayer;
    id mSystems;
    SpriteRenderer* mRenderer;
    OFList* mBullets;
    OFList* mEnemies1;
    OFList* mEnemies2;
    OFList* mEnemies3;
    OFList* mExplosions;
    OFList* mBangs;
    OFList* mParticles;
    ArtemisWorld* mWorld;
}
@property (nonatomic, retain) OFList* Bullets;
@property (nonatomic, retain) OFList* Enemies1;
@property (nonatomic, retain) OFList* Enemies2;
@property (nonatomic, retain) OFList* Enemies3;
@property (nonatomic, retain) OFList* Explosions;
@property (nonatomic, retain) OFList* Bangs;
@property (nonatomic, retain) OFList* Particles;

- (instancetype)initWithWidth:(int)width 
                       Height:(int)height;
- (OFString*)description;
- (void)SetSystem:(Systems*)systems;
- (void)Initialize;
- (void)LoadContent;
- (void)Update:(GLfloat) delta;
- (void)Draw:(GLfloat) delta;
- (Entity*)GetEntity:(int)index;

@end