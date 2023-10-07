#import <Foundation/Foundation.h>
#import <xna/xna.h>
#import <Artemis/Artemis.h>
#import "Components.h"
#import "Factory.h"
#import "Components/Position.h"
#import "Components/Velocity.h"
#import "Systems/MovementSystem.h"

@class Systems;

@interface Shmupwarz : Game 
{
    Entity *mPlayer;
    id mSystems;
    SpriteRenderer* mRenderer;
    NSMutableArray<Vector2D*> *mBullets;
    NSMutableArray<Vector2D*> *mEnemies1;
    NSMutableArray<Vector2D*> *mEnemies2;
    NSMutableArray<Vector2D*> *mEnemies3;
    NSMutableArray<Vector2D*> *mExplosions;
    NSMutableArray<Vector2D*> *mBangs;
    NSMutableArray<Vector2D*> *mParticles;
    MovementSystem* mMovementSystem;
    ArtemisEntity* mShip; 
    ArtemisWorld* mWorld;
    Position* mPosition;
    Velocity* mVelocity;

}
@property (nonatomic, retain) NSMutableArray<Vector2D*> *Bullets;
@property (nonatomic, retain) NSMutableArray<Vector2D*> *Enemies1;
@property (nonatomic, retain) NSMutableArray<Vector2D*> *Enemies2;
@property (nonatomic, retain) NSMutableArray<Vector2D*> *Enemies3;
@property (nonatomic, retain) NSMutableArray<Vector2D*> *Explosions;
@property (nonatomic, retain) NSMutableArray<Vector2D*> *Bangs;
@property (nonatomic, retain) NSMutableArray<Vector2D*> *Particles;

- (instancetype)initWithTitle:(NSString*)title
                        Width:(int)width 
                       Height:(int)height;
- (NSString*)ToString;
- (void)SetSystem:(Systems*)systems;
- (void)Initialize;
- (void)LoadContent;
- (void)Update:(GLfloat) delta;
- (void)Draw:(GLfloat) delta;
- (Entity*)GetEntity:(int)index;

@end