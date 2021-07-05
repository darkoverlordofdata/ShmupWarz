#import "Factory.h"
@implementation Factory

// entity cache:
static OFMutableArray* mEntities = nil;
static OFMutableArray* mActive = nil;
static OFMutableArray* mInput = nil;
static OFMutableArray* mSound = nil;
static OFMutableArray* mVelocity = nil;
static OFMutableArray* mExpire = nil;
static OFMutableArray* mTween = nil;
static OFMutableArray* mHealth = nil;

+ (void) initialize {
    mEntities   = [OFMutableArray new];
    mActive     = [OFMutableArray new];
    mInput      = [OFMutableArray new];
    mSound      = [OFMutableArray new];
    mVelocity   = [OFMutableArray new];
    mExpire     = [OFMutableArray new];
    mTween      = [OFMutableArray new];
    mHealth     = [OFMutableArray new];
}

+ (OFMutableArray*) Entities { return mEntities; }
+ (OFMutableArray*) Active { return mActive; }
+ (OFMutableArray*) Input { return mInput; }
+ (OFMutableArray*) Sound { return mSound; }
+ (OFMutableArray*) Velocity { return mVelocity; }
+ (OFMutableArray*) Expire { return mExpire; }
+ (OFMutableArray*) Tween { return mTween; }
+ (OFMutableArray*) Health { return mHealth; }


+ (void) CreateBackground { 
    let entity = [[Entity alloc]initWithId:[mEntities count] Name:@"background" Active:true];
    entity.Identity = [[Identity alloc]initWithType:TYPE_BACKGROUND Category:CATEGORY_BACKGROUND];
    entity.Transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"background"] Scale:2.0];
    [mActive addObject:entity];
    [mEntities addObject:entity];
}

+ (Entity*) CreatePlayer { 
    let entity = [[Entity alloc]initWithId:[mEntities count] Name:@"player" Active:true];
    entity.Identity = [[Identity alloc]initWithType:TYPE_PLAYER Category:CATEGORY_PLAYER];
    entity.Transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"spaceshipspr"]];
    [mActive addObject:entity];
    [mInput addObject:entity];
    [mEntities addObject:entity];
    return entity;
}

+ (void) CreateBullet { 
    let entity = [[Entity alloc]initWithId:[mEntities count] Name:@"bullet" Active:false];
    entity.Identity = [[Identity alloc]initWithType:TYPE_BULLET Category:CATEGORY_BULLET];
    entity.Transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"bullet"]];
    [mSound addObject:entity];
    [mHealth addObject:entity];
    [mVelocity addObject:entity];
    [mEntities addObject:entity];
}

+ (void) CreateEnemy1 { 
    let entity = [[Entity alloc]initWithId:[mEntities count] Name:@"enemy1" Active:false];
    entity.Identity = [[Identity alloc]initWithType:TYPE_ENEMY1 Category:CATEGORY_ENEMY];
    entity.Transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"enemy1"]];
    [mHealth addObject:entity];
    [mVelocity addObject:entity];
    [mEntities addObject:entity];
}

+ (void) CreateEnemy2 { 
    let entity = [[Entity alloc]initWithId:[mEntities count] Name:@"enemy2" Active:false];
    entity.Identity = [[Identity alloc]initWithType:TYPE_ENEMY2 Category:CATEGORY_ENEMY];
    entity.Transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"enemy2"]];
    [mHealth addObject:entity];
    [mVelocity addObject:entity];
    [mEntities addObject:entity];
}

+ (void) CreateEnemy3 { 
    let entity = [[Entity alloc]initWithId:[mEntities count] Name:@"enemy3" Active:false];
    entity.Identity = [[Identity alloc]initWithType:TYPE_ENEMY3 Category:CATEGORY_ENEMY];
    entity.Transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"enemy3"]];
    [mHealth addObject:entity];
    [mVelocity addObject:entity];
    [mEntities addObject:entity];
}

+ (void) CreateExplosion { 
    let entity = [[Entity alloc]initWithId:[mEntities count] Name:@"explosion" Active:false];
    entity.Identity = [[Identity alloc]initWithType:TYPE_EXPLOSION Category:CATEGORY_EXPLOSION];
    entity.Transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"explosion"] Scale:0.6];
    [mTween addObject:entity];
    [mEntities addObject:entity];
}

+ (void) CreateBang { 
    let entity = [[Entity alloc]initWithId:[mEntities count] Name:@"bang" Active:false];
    entity.Identity = [[Identity alloc]initWithType:TYPE_BANG Category:CATEGORY_EXPLOSION];
    entity.Transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"explosion"] Scale:0.4];
    [mTween addObject:entity];
    [mEntities addObject:entity];
}

+ (void) CreateParticle { 
    let entity = [[Entity alloc]initWithId:[mEntities count] Name:@"particle" Active:false];
    entity.Identity = [[Identity alloc]initWithType:TYPE_PARTICLE Category:CATEGORY_PARTICLE];
    entity.Transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"star"]];
    [mTween addObject:entity];
    [mVelocity addObject:entity];
    [mEntities addObject:entity];
}

+ (void) Bullet:(Entity*) entity X:(int) x Y:(int) y { 
    entity.Transform.Pos.X = x;
    entity.Transform.Pos.Y = y;
    entity.Expires = [[Timer alloc]initWithMs:1.0];
    entity.Sound = [[Sound alloc]initWithPath:"assets/Sounds/pew.wav"];
    entity.Health = [[Health alloc]initWithCurrent:2 Maximum:2];
    entity.Tint = [[Color alloc]initWithR:0xd2 G:0xfa B:0x00 A:0xffa];
    entity.Velocity = [[Vector2D alloc]initWithX:0 Y:-800];
    entity.Active = true;
    [mActive addObject:entity];
}

+ (void) Enemy1:(Entity*) entity X:(int) x Y:(int) y { 
    entity.Transform.Pos.X = x;
    entity.Transform.Pos.Y = y;
    entity.Health = [[Health alloc]initWithCurrent:10 Maximum:10];
    entity.Velocity = [[Vector2D alloc]initWithX:0 Y:40];
    entity.Active = true;
    [mActive addObject:entity];
}

+ (void) Enemy2:(Entity*) entity X:(int) x Y:(int) y { 
    entity.Transform.Pos.X = x;
    entity.Transform.Pos.Y = y;
    entity.Health = [[Health alloc]initWithCurrent:20 Maximum:20];
    entity.Velocity = [[Vector2D alloc]initWithX:0 Y:30];
    entity.Active = true;
    [mActive addObject:entity];
}

+ (void) Enemy3:(Entity*) entity X:(int) x Y:(int) y { 
    entity.Transform.Pos.X = x;
    entity.Transform.Pos.Y = y;
    entity.Health = [[Health alloc]initWithCurrent:60 Maximum:60];
    entity.Velocity = [[Vector2D alloc]initWithX:0 Y:20];
    entity.Active = true;
    [mActive addObject:entity];
}

+ (void) Explosion:(Entity*) entity X:(int) x Y:(int) y { 
    let scale = 0.6;
    entity.Transform.Pos.X = x;
    entity.Transform.Pos.Y = y;
    entity.Transform.Bounds = (SDL_Rect){ x, y, entity.Transform.Bounds.w, entity.Transform.Bounds.h };
    entity.Transform.Scale.X = scale;
    entity.Transform.Scale.Y = scale;
    entity.Sound = [[Sound alloc]initWithPath:"assets/Sounds/asplode.wav"];
    entity.Tween = [[Tween alloc]initWithMin:scale/100.0 Max:scale Speed:-3 Repeat:false Active:false];
    entity.Tint = [[Color alloc]initWithR:0xd2 G:0xfa B:0xd2 A:0xfa];
    entity.Expires = [[Timer alloc]initWithMs:0.2];
    entity.Active = true;
    [mActive addObject:entity];
}

+ (void) Bang:(Entity*) entity X:(int) x Y:(int) y { 
    let scale = 0.2;
    entity.Transform.Pos.X = x;
    entity.Transform.Pos.Y = y;
    entity.Transform.Bounds = (SDL_Rect){ x, y, entity.Transform.Bounds.w, entity.Transform.Bounds.h };
    entity.Transform.Scale.X = scale;
    entity.Transform.Scale.Y = scale;
    entity.Sound = [[Sound alloc]initWithPath:"assets/Sounds/smallasplode.wav"];
    entity.Tween = [[Tween alloc]initWithMin:scale/100.0 Max:scale Speed:-3 Repeat:false Active:false];
    entity.Tint = [[Color alloc]initWithR:0xd2 G:0xfa B:0xd2 A:0xfa];
    entity.Expires = [[Timer alloc]initWithMs:0.2];
    entity.Active = true;
    [mActive addObject:entity];
}

+ (void) Particle:(Entity*) entity X:(int) x Y:(int) y { 
    let Tau = 6.28318;
    double r1 = ((double)rand()/(double)1.0);
    double radians = r1 * (double)Tau;
    double magnitude = rand() % 100 + 50;
    double velocityX = magnitude * cos(radians);
    double velocityY = magnitude * sin(radians);
    double scale = (double)(rand() % 10) / 10.0;

    entity.Transform.Pos.X = x;
    entity.Transform.Pos.Y = y;
    entity.Transform.Bounds = (SDL_Rect){ x, y, entity.Transform.Bounds.w, entity.Transform.Bounds.h };
    entity.Transform.Scale.X = scale;
    entity.Transform.Scale.Y = scale;
    entity.Velocity = [[Vector2D alloc]initWithX:velocityX Y:velocityY];
    entity.Expires = [[Timer alloc]initWithMs:0.75];
    entity.Active = true;
    [mActive addObject:entity];
}

@end