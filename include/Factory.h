#import <Foundation/Foundation.h>
#import <DarkoGameKit/DarkoGameKit.h>
#import <Components.h>

// Entity Factory

@interface Factory : NSObject  {}

@property (class, nonatomic, readonly, retain) NSMutableArray* Entities;
@property (class, nonatomic, readonly, retain) NSMutableArray* Active;
@property (class, nonatomic, readonly, retain) NSMutableArray* Input;
@property (class, nonatomic, readonly, retain) NSMutableArray* Sound;
@property (class, nonatomic, readonly, retain) NSMutableArray* Velocity;
@property (class, nonatomic, readonly, retain) NSMutableArray* Expire;
@property (class, nonatomic, readonly, retain) NSMutableArray* Tween;
@property (class, nonatomic, readonly, retain) NSMutableArray* Health;


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