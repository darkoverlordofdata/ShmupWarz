#import <Foundation/Foundation.h>
#import <xna/xna.h>
#import <Components.h>

@interface Factory : OFObject  {}

@property (class, nonatomic, readonly, retain) OFMutableArray* Entities;
@property (class, nonatomic, readonly, retain) OFMutableArray* Active;
@property (class, nonatomic, readonly, retain) OFMutableArray* Input;
@property (class, nonatomic, readonly, retain) OFMutableArray* Sound;
@property (class, nonatomic, readonly, retain) OFMutableArray* Velocity;
@property (class, nonatomic, readonly, retain) OFMutableArray* Expire;
@property (class, nonatomic, readonly, retain) OFMutableArray* Tween;
@property (class, nonatomic, readonly, retain) OFMutableArray* Health;


+ (void) initialize;
+ (void) CreateBackground;
+ (Entity*) CreatePlayer;
+ (void) CreateBullet;
+ (void) CreateEnemy1;
+ (void) CreateEnemy2;
+ (void) CreateEnemy3;
+ (void) CreateExplosion;
+ (void) CreateBang;
+ (void) CreateParticle;



+ (void) Bullet:(Entity*) entity X:(int) x Y:(int) y;
+ (void) Enemy1:(Entity*) entity X:(int) x Y:(int) y;
+ (void) Enemy2:(Entity*) entity X:(int) x Y:(int) y;
+ (void) Enemy3:(Entity*) entity X:(int) x Y:(int) y;
+ (void) Explosion:(Entity*) entity X:(int) x Y:(int) y;
+ (void) Bang:(Entity*) entity X:(int) x Y:(int) y;
+ (void) Particle:(Entity*) entity X:(int) x Y:(int) y;


@end