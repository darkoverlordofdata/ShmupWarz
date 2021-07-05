#import <Foundation/Foundation.h>
#import <SDL2/SDL.h>
#import <tglm/tglm.h>
#import "../OpenGL.h"
#import "Texture2D.h"
#import "Shader.h"

@interface SpriteRenderer : OFObject  
{
    Shader *mShader; 
    GLuint mQuadVAO;
}

- (instancetype)initWithShader:(Shader*)shader;
- (OFString*)description;



- (void)DrawSprite:(Texture2D*)texture 
Bounds:(SDL_Rect*)bounds
Rotate:(GLfloat)rotate 
Color:(Vec3)color;
- (void)InitRenderData;

@end