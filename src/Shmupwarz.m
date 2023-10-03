#import "Shmupwarz.h"
#import "Systems.h"
#import <stdio.h>
#define var __auto_type
#define let const var
extern OpenGL GL;

@implementation Shmupwarz

@synthesize Bullets = mBullets;
@synthesize Enemies1 = mEnemies1;
@synthesize Enemies2 = mEnemies2;
@synthesize Enemies3 = mEnemies3;
@synthesize Explosions = mExplosions;
@synthesize Bangs = mBangs;
@synthesize Particles = mParticles;

- (instancetype)initWithTitle:(NSString*)title
                        Width:(int)width 
                       Height:(int)height
{
    if ((self = [super initWithTitle:title Width:width Height:height])) {
        mBullets = [NSMutableArray new];
        mEnemies1 = [NSMutableArray new];
        mEnemies2 = [NSMutableArray new];
        mEnemies3 = [NSMutableArray new];
        mExplosions = [NSMutableArray new];
        mBangs = [NSMutableArray new];
        mParticles = [NSMutableArray new];
    }
    return self;
}

- (void)Initialize{

    NSLog(@"Initialize Artemis");
    mWorld = [ArtemisWorld new];

    mShip = [mWorld createEntity];
    mPosition = [Position positionWithX:0 y:0];
    mVelocity = [Velocity velocityWithDeltaX:10 deltaY:20];
    [mShip addComponent:mPosition];
    [mShip addComponent:mVelocity];

    mMovementSystem = [MovementSystem movementSystem];
    [mMovementSystem initialize];
    [mWorld initialize];
    [mWorld setSystem:mMovementSystem];
    [mWorld enable: mShip];

};

- (NSString*)ToString { return @"Shmupwarz"; }
- (void)SetSystem:(Systems*)systems { mSystems = systems; }
- (Entity*)GetEntity:(int)index { return Factory.Entities[index]; }

- (void)Draw:(GLfloat) delta {
    // [self Draw:delta];
    GL.ClearColor(1.0f, 0.0f, 0.0f, 1.0f);
    GL.Clear(GL_COLOR_BUFFER_BIT);
    // for (Entity* e in Factory.Entities) [mSystems DrawSystem:mRenderer Entity:e];
    for (Entity* e in Factory.Active) [mSystems Draw:mRenderer Entity:e];
    SDL_GL_SwapWindow(mWindow);
}

- (void)Update:(GLfloat) delta {

    [mWorld process];

    for (Entity* e in Factory.Input)    [mSystems Spawn:e];
    for (Entity* e in Factory.Input)    [mSystems Input:e];
    for (Entity* e in Factory.Health)   [mSystems Collision:e];
    for (Entity* e in Factory.Entities) [mSystems Recycle:e];
    for (Entity* e in Factory.Active)   [mSystems Physics:e];
    for (Entity* e in Factory.Tween)    [mSystems Tween:e];
    for (Entity* e in Factory.Entities) [mSystems Kill:e];
}

- (void)LoadContent {


    // Load shaders
    [ResourceManager LoadShader:@"sprite"   Vertex:@"sprite.vs"   Fragment:@"sprite.frag"];
    [ResourceManager LoadShader:@"particle" Vertex:@"particle.vs" Fragment:@"particle.frag"];


    // Configure shaders
    Mat projection = glm_ortho(0.0f, mWidth, mHeight, 0.0f, -1.0f, 1.0f);

    let sprite = [ResourceManager GetShader:@"sprite"];
    [sprite Use];
    [sprite SetInteger:"sprite" Value:0];
    [sprite SetMatrix4:"projection" Value:projection];

    let particle = [ResourceManager GetShader:@"particle"];
    [particle Use];
    [particle SetInteger:"particle" Value:0];
    [particle SetMatrix4:"projection" Value:projection];


    // Load textures
    [ResourceManager LoadTexture:@"background"  Path:@"background.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"bang"        Path:@"bang.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"bullet"      Path:@"bullet.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"enemy1"      Path:@"enemy1.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"enemy2"      Path:@"enemy2.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"enemy3"      Path:@"enemy3.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"explosion"   Path:@"explosion.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"particle"    Path:@"particle.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"spaceshipspr" Path:@"spaceshipspr.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"star"        Path:@"star.png" Alpha:GL_TRUE];

    // Create the entity pool
    [Factory CreateBackground];
    for (int i=0; i<12; i++)    [Factory CreateBullet];
    for (int i=0; i<15; i++)    [Factory CreateEnemy1];
    for (int i=0; i<5; i++)     [Factory CreateEnemy2];
    for (int i=0; i<4; i++)     [Factory CreateEnemy3];
    for (int i=0; i<10; i++)    [Factory CreateExplosion];
    for (int i=0; i<12; i++)    [Factory CreateBang];
    for (int i=0; i<100; i++)   [Factory CreateParticle];
    mPlayer = [Factory CreatePlayer];

    mRenderer = [[SpriteRenderer alloc]initWithShader:[ResourceManager GetShader:@"sprite"]];
}

@end
