#import "Shmupwarz.h"
#import "Systems.h"
#import "tglm/tglm.h"

@implementation Shmupwarz

@synthesize Bullets = mBullets;
@synthesize Enemies1 = mEnemies1;
@synthesize Enemies2 = mEnemies2;
@synthesize Enemies3 = mEnemies3;
@synthesize Explosions = mExplosions;
@synthesize Bangs = mBangs;
@synthesize Particles = mParticles;

- (instancetype)initWithWidth:(int)width 
                       Height:(int)height 
{
    if ((self = [super initWithWidth:width Height:height])) {
        mBullets = [OFList new];
        mEnemies1 = [OFList new];
        mEnemies2 = [OFList new];
        mEnemies3 = [OFList new];
        mExplosions = [OFList new];
        mBangs = [OFList new];
        mParticles = [OFList new];
    }
    return self;
}

- (OFString*)ToString { return @"Shmupwarz"; }
- (void)SetSystem:(Systems*)systems { mSystems = systems; }
- (Entity*)GetEntity:(int)index { return Factory.Entities[index]; }

- (void)Draw:(GLfloat) delta {
    GL.ClearColor(1.0f, 0.0f, 0.0f, 1.0f);
    GL.Clear(GL_COLOR_BUFFER_BIT);
    // for (Entity* e in Factory.Entities) [mSystems DrawSystem:mRenderer Entity:e];
    for (Entity* e in Factory.Active) [mSystems Draw:mRenderer Entity:e];
    SDL_GL_SwapWindow(mWindow);
}

- (void)Update:(GLfloat) delta {

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
    [ResourceManager LoadShader:@"sprite"   Vertex:@"assets/shaders/sprite.vs"   Fragment:@"assets/shaders/sprite.frag"];
    [ResourceManager LoadShader:@"particle" Vertex:@"assets/shaders/particle.vs" Fragment:@"assets/shaders/particle.frag"];

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
    [ResourceManager LoadTexture:@"background"  Path:@"assets/images/background.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"bang"        Path:@"assets/images/bang.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"bullet"      Path:@"assets/images/bullet.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"enemy1"      Path:@"assets/images/enemy1.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"enemy2"      Path:@"assets/images/enemy2.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"enemy3"      Path:@"assets/images/enemy3.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"explosion"   Path:@"assets/images/explosion.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"particle"    Path:@"assets/images/particle.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"spaceshipspr" Path:@"assets/images/spaceshipspr.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"star"        Path:@"assets/images/star.png" Alpha:GL_TRUE];

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
