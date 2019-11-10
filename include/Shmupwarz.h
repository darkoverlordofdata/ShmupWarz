#import <Foundation/Foundation.h>
#import <xna/xna.h>
#import "Components.h"
#import "Factory.h"

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
- (OFString*)ToString;
- (void)SetSystem:(Systems*)systems;
- (void)Initialize;
- (void)LoadContent;
- (void)Update:(GLfloat) delta;
- (void)Draw:(GLfloat) delta;
- (Entity*)GetEntity:(int)index;

@end