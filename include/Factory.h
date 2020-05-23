#import <XCore.h>
#import <xna/xna.h>
#import <Components.h>

@interface Factory : NSObject  {}



+ (void) initialize;
+ (void) CreateBackground:(ArtemisWorld*) world Width:(int) width Height:(int) height;
+ (void) CreatePlayer:(ArtemisWorld*) world X:(int) x Y:(int) y;
+ (void) CreateBullet:(ArtemisWorld*) world X:(int) x Y:(int) y;
+ (void) CreateEnemy1:(ArtemisWorld*) world X:(int) x Y:(int) y;
+ (void) CreateEnemy2:(ArtemisWorld*) world X:(int) x Y:(int) y;
+ (void) CreateEnemy3:(ArtemisWorld*) world X:(int) x Y:(int) y;
+ (void) CreateExplosion:(ArtemisWorld*) world X:(int) x Y:(int) y;
+ (void) CreateBang:(ArtemisWorld*) world X:(int) x Y:(int) y;
+ (void) CreateParticle:(ArtemisWorld*) world X:(int) x Y:(int) y;



// + (void) Bullet:(Entity*) entity X:(int) x Y:(int) y;
// + (void) Enemy1:(Entity*) entity X:(int) x Y:(int) y;
// + (void) Enemy2:(Entity*) entity X:(int) x Y:(int) y;
// + (void) Enemy3:(Entity*) entity X:(int) x Y:(int) y;
// + (void) Explosion:(Entity*) entity X:(int) x Y:(int) y;
// + (void) Bang:(Entity*) entity X:(int) x Y:(int) y;
// + (void) Particle:(Entity*) entity X:(int) x Y:(int) y;


@end