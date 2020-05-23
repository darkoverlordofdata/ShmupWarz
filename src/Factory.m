#import "Factory.h"
@implementation Factory

// entity cache:
+ (void) initialize {
}

+ (void) CreateBackground:(ArtemisWorld*) world Width:(int) width Height:(int) height {
    let entity = [world createEntity];
    let identity = [[Identity alloc]initWithType:TYPE_BACKGROUND Category:CATEGORY_BACKGROUND];
    let transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"background"] Scale:2.0 Center:false];
    [transform X:0 Y:0 W:width H:height];
    [entity addComponent:identity];
    [entity addComponent:transform];
    [world addEntity:entity];
    NSLog(@"CreateBackground");

}

+ (void) CreatePlayer:(ArtemisWorld*) world X:(int) x Y:(int) y {
    let entity = [world createEntity];
    let player = [Player new];
    let identity = [[Identity alloc]initWithType:TYPE_PLAYER Category:CATEGORY_PLAYER];
    let transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"spaceship"]];

    [entity addComponent:player];
    [entity addComponent:identity];
    [entity addComponent:transform];
    [world addEntity:entity];
    NSLog(@"CreatePlayer");
}

+ (void) CreateBullet:(ArtemisWorld*) world X:(int) x Y:(int) y {
    let entity = [world createEntity];
    let identity = [[Identity alloc]initWithType:TYPE_BULLET Category:CATEGORY_BULLET];
    let transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"bullet"]];
    transform.Pos.X = x;
    transform.Pos.Y = y;
    transform.Tint = (Vec3) { 0xd2, 0xfa, 0x00, 0xffa };
    let expires = [[Timer alloc]initWithMs:1.0];
    let sound = [[Sound alloc]initWithPath:"assets/Sounds/pew.wav"];
    let health = [[Health alloc]initWithCurrent:2 Maximum:2];
    let velocity = [[Velocity alloc]initWithX:0 Y:-800];

    [entity addComponent:identity];
    [entity addComponent:transform];
    [entity addComponent:expires];
    [entity addComponent:sound];
    [entity addComponent:health];
    [entity addComponent:velocity];
    [world addEntity:entity];
    NSLog(@"CreateBullet %@ %d { %d, %d, %d, %d }", entity, entity.isActive, transform.Bounds.x, transform.Bounds.y, transform.Bounds.w, transform.Bounds.h);
}

+ (void) CreateEnemy1:(ArtemisWorld*) world X:(int) x Y:(int) y { 
    let entity = [world createEntity];
    let identity = [[Identity alloc]initWithType:TYPE_ENEMY1 Category:CATEGORY_ENEMY];
    let transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"enemy1"]];
    transform.Pos.X = x;
    transform.Pos.Y = y;
    let health = [[Health alloc]initWithCurrent:10 Maximum:10];
    let velocity = [[Velocity alloc]initWithX:0 Y:40];

    [entity addComponent:identity];
    [entity addComponent:transform];
    [entity addComponent:health];
    [entity addComponent:velocity];
    [world addEntity:entity];
    NSLog(@"CreateEnemy1");
}

+ (void) CreateEnemy2:(ArtemisWorld*) world X:(int) x Y:(int) y { 
    let entity = [world createEntity];
    let identity = [[Identity alloc]initWithType:TYPE_ENEMY2 Category:CATEGORY_ENEMY];
    let transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"enemy2"]];
    transform.Pos.X = x;
    transform.Pos.Y = y;
    let health = [[Health alloc]initWithCurrent:20 Maximum:20];
    let velocity = [[Velocity alloc]initWithX:0 Y:30];

    [entity addComponent:identity];
    [entity addComponent:transform];
    [entity addComponent:health];
    [entity addComponent:velocity];
    [world addEntity:entity];
    NSLog(@"CreateEnemy2");
}

+ (void) CreateEnemy3:(ArtemisWorld*) world X:(int) x Y:(int) y { 
    let entity = [world createEntity];
    let identity = [[Identity alloc]initWithType:TYPE_ENEMY3 Category:CATEGORY_ENEMY];
    let transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"enemy3"]];
    transform.Pos.X = x;
    transform.Pos.Y = y;
    let health = [[Health alloc]initWithCurrent:60 Maximum:60];
    let velocity = [[Velocity alloc]initWithX:0 Y:20];

    [entity addComponent:identity];
    [entity addComponent:transform];
    [entity addComponent:health];
    [entity addComponent:velocity];
    [world addEntity:entity];
    NSLog(@"CreateEnemy3");
}

+ (void) CreateExplosion:(ArtemisWorld*) world X:(int) x Y:(int) y { 
    let scale = 0.6;
    let entity = [world createEntity];
    let identity = [[Identity alloc]initWithType:TYPE_EXPLOSION Category:CATEGORY_EXPLOSION];
    let transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"explosion"] Scale:0.6];
    transform.Pos.X = x;
    transform.Pos.Y = y;
    transform.Bounds = (SDL_Rect){ x, y, transform.Bounds.w, transform.Bounds.h };
    transform.Scale.X = scale;
    transform.Scale.Y = scale;
    transform.Tint = (Vec3) { 0xd2, 0xfa, 0xd2, 0xfa };
    let sound = [[Sound alloc]initWithPath:"assets/Sounds/asplode.wav"];
    let tween = [[Tween alloc]initWithMin:scale/100.0 Max:scale Speed:-3 Repeat:false Active:false];
    let expires = [[Timer alloc]initWithMs:0.2];

    [entity addComponent:identity];
    [entity addComponent:transform];
    [entity addComponent:sound];
    [entity addComponent:tween];
    [entity addComponent:expires];
    [world addEntity:entity];
    NSLog(@"CreateExplosion");
}

+ (void) CreateBang:(ArtemisWorld*) world X:(int) x Y:(int) y { 
    let scale = 0.2;
    let entity = [world createEntity];
    let identity = [[Identity alloc]initWithType:TYPE_BANG Category:CATEGORY_EXPLOSION];
    let transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"explosion"] Scale:0.4];
    transform.Pos.X = x;
    transform.Pos.Y = y;
    transform.Bounds = (SDL_Rect){ x, y, transform.Bounds.w, transform.Bounds.h };
    transform.Scale.X = scale;
    transform.Scale.Y = scale;
    transform.Tint = (Vec3) { 0xd2, 0xfa, 0xd2, 0xfa };
    let sound = [[Sound alloc]initWithPath:"assets/Sounds/smallasplode.wav"];
    let tween = [[Tween alloc]initWithMin:scale/100.0 Max:scale Speed:-3 Repeat:false Active:false];
    let expires = [[Timer alloc]initWithMs:0.2];

    [entity addComponent:identity];
    [entity addComponent:transform];
    [entity addComponent:sound];
    [entity addComponent:tween];
    [entity addComponent:expires];
    [world addEntity:entity];
    NSLog(@"CreateBang");
}

+ (void) CreateParticle:(ArtemisWorld*) world X:(int) x Y:(int) y { 
    let entity = [world createEntity];
    let identity = [[Identity alloc]initWithType:TYPE_PARTICLE Category:CATEGORY_PARTICLE];
    let transform = [[Transform alloc]initWithTexture:[ResourceManager GetTexture:@"star"]];
    let Tau = 6.28318;
    double r1 = ((double)rand()/(double)1.0);
    double radians = r1 * (double)Tau;
    double magnitude = rand() % 100 + 50;
    double velocityX = magnitude * cos(radians);
    double velocityY = magnitude * sin(radians);
    double scale = (double)(rand() % 10) / 10.0;

    transform.Pos.X = x;
    transform.Pos.Y = y;
    transform.Bounds = (SDL_Rect){ x, y, transform.Bounds.w, transform.Bounds.h };
    transform.Scale.X = scale;
    transform.Scale.Y = scale;
    let velocity = [[Velocity alloc]initWithX:velocityX Y:velocityY];
    let expires = [[Timer alloc]initWithMs:0.75];

    [entity addComponent:identity];
    [entity addComponent:transform];
    [entity addComponent:expires];
    [entity addComponent:velocity];
    [world addEntity:entity];
    NSLog(@"CreateParticle");
}



@end