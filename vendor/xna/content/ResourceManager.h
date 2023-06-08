#import <Foundation/Foundation.h>
#import <SDL2/SDL.h>
#import <SDL2/SDL_image.h>
#import "../OpenGL.h"
#import "../graphics/Texture2D.h"
#import "../graphics/Shader.h"


@interface ResourceManager : NSObject
@property (nonatomic, retain) NSMutableDictionary* Shaders;
@property (nonatomic, retain) NSMutableDictionary* Textures;

+ (Shader*)LoadShader:(NSString*)name Vertex:(NSString*) vertex Fragment:(NSString *)fragment;
+ (Shader*)GetShader:(NSString*)name;
+ (Texture2D*)LoadTexture:(NSString*)name Path:(NSString*)path Alpha:(GLboolean)alpha;
+ (Texture2D*)GetTexture:(NSString*)name;
+ (void)Clear;

+ (Shader*)LoadShaderFromFile:(NSString*) vertex Fragment:(NSString*) fragment;
+ (Texture2D*)LoadTextureFromFile:(NSString*)path Alpha:(GLboolean)alpha;
+ (NSString*)ResourcePath:(NSString*)filename;
@end