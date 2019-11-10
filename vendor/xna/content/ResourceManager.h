#import <Foundation/Foundation.h>
#import <OpenGL.h>
#import <SDL2/SDL.h>
#import "../graphics/Texture2D.h"
#import "../graphics/Shader.h"

@interface ResourceManager : OFObject;
@property (class) OFMutableDictionary* Shaders;
@property (class) OFMutableDictionary* Textures;

+ (Shader*)LoadShader:(OFString*)name Vertex:(OFString*) vertex Fragment:(OFString *)fragment;
+ (Shader*)GetShader:(OFString*)name;
+ (Texture2D*)LoadTexture:(OFString*)name Path:(OFString*)path Alpha:(GLboolean)alpha;
+ (Texture2D*)GetTexture:(OFString*)name;
+ (void)Clear;

+ (Shader*)LoadShaderFromFile:(OFString*) vertex Fragment:(OFString*) fragment;
+ (Texture2D*)LoadTextureFromFile:(OFString*)path Alpha:(GLboolean)alpha;
@end