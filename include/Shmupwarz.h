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
    NSMutableArray* mBullets;
    NSMutableArray* mEnemies1;
    NSMutableArray* mEnemies2;
    NSMutableArray* mEnemies3;
    NSMutableArray* mExplosions;
    NSMutableArray* mBangs;
    NSMutableArray* mParticles;
}
@property (nonatomic, retain) NSMutableArray* Bullets;
@property (nonatomic, retain) NSMutableArray* Enemies1;
@property (nonatomic, retain) NSMutableArray* Enemies2;
@property (nonatomic, retain) NSMutableArray* Enemies3;
@property (nonatomic, retain) NSMutableArray* Explosions;
@property (nonatomic, retain) NSMutableArray* Bangs;
@property (nonatomic, retain) NSMutableArray* Particles;

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