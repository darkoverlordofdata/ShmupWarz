#import "Shmupwarz.h"
#import "Components.h"
#import "Systems.h"
#import "tglm/tglm.h"

@implementation Shmupwarz

static Shmupwarz* _instance = nil;

@synthesize World = mWorld;

+ (Shmupwarz*)Instance { return _instance; }

- (instancetype)initWithWidth:(int)width 
                       Height:(int)height 
{
    if ((self = [super initWithWidth:width Height:height])) {
        _instance = self;
    }
    return self;
}

- (NSString*)description { return @"Shmupwarz"; }

- (void)Initialize {
}

- (void)Draw:(GLfloat) delta {
    GL.ClearColor(1.0f, 0.0f, 0.0f, 1.0f);
    GL.Clear(GL_COLOR_BUFFER_BIT);
    [System Draw:[renderer withEntity:entity]];
    SDL_GL_SwapWindow(mWindow);
}

- (void)Update:(GLfloat) delta {
    self.delta = delta;

    [System Spawn:entity];
    [System Input:entity];
    [System Collision:entity];
    [System Sound:entity];
    [System Physics:entity];
    [System Tween:entity];
    [System Kill:entity];
    [System Recycle:entity];

}

- (void)LoadContent {

    mSystems = [[Systems alloc]initWithGame:self];

    // Load shaders
    [ResourceManager LoadShader:@"sprite"   Vertex:@"assets/shaders/sprite.vs"   Fragment:@"assets/shaders/sprite.frag"];
    [ResourceManager LoadShader:@"particle" Vertex:@"assets/shaders/particle.vs" Fragment:@"assets/shaders/particle.frag"];

    // Configure shaders
    let projection = glm_ortho(0.0f, mWidth, mHeight, 0.0f, -1.0f, 1.0f);

    let sprite = [ResourceManager GetShader:@"sprite"]
        .SetInteger("sprite", 0).SetMatrix4("projection", projection);

    let particle = [ResourceManager GetShader:@"particle"]
        .SetInteger("particle", 0).SetMatrix4("projection", projection);

    // Load textures
    [ResourceManager LoadTexture:@"background"  Path:@"assets/images/background.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"bang"        Path:@"assets/images/bang.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"bullet"      Path:@"assets/images/bullet.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"enemy1"      Path:@"assets/images/enemy1.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"enemy2"      Path:@"assets/images/enemy2.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"enemy3"      Path:@"assets/images/enemy3.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"explosion"   Path:@"assets/images/explosion.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"particle"    Path:@"assets/images/particle.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"spaceship"   Path:@"assets/images/spaceshipspr.png" Alpha:GL_TRUE];
    [ResourceManager LoadTexture:@"star"        Path:@"assets/images/star.png" Alpha:GL_TRUE];

    [mWorld initialize];

    // Create the entity pool
    [Factory CreateBackground:mWorld Width:mWidth Height:mHeight];
    [Factory CreatePlayer:mWorld X:0 Y:0];
}

@end
