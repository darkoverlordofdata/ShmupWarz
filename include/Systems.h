#import <Foundation/Foundation.h>
#import <xna/xna.h>
#import "Components.h"
#import "Factory.h"

@class Shmupwarz;

static const double FireRate = 0.1;

@interface Systems : NSObject {
    Shmupwarz* mGame;
    Factory* mFactory;
    double mTimeToFire;
    double mEnemyT1;
    double mEnemyT2;
    double mEnemyT3;
}

- (instancetype)initWithGame:(Shmupwarz*)game;
- (void) Draw:(SpriteRenderer*) renderer Entity:(Entity*) e;
- (void) Input:(Entity*) entity;
- (void) Spawn:(Entity*) entity;
- (void) Sound:(Entity*) entity;
- (void) Physics:(Entity*) entity;
- (void) Tween:(Entity*) entity;
- (void) Collision:(Entity*) entity;
- (void) Kill:(Entity*) entity;
- (void) Recycle:(Entity*) entity;

- (double) SpawnEnemy:(double) delta T:(double) t Enemy:(int) enemy;
- (void) HandleCollision:(Entity*) a Other:(Entity*) b;

@end