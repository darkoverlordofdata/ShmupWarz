#import "ResourceManager.h"

@implementation ResourceManager;

static NSMutableDictionary* _shaders = nil;
static NSMutableDictionary* _textures = nil;

+ (void) initialize {
    if (self == [ResourceManager class]) {
        _shaders = [[NSMutableDictionary alloc] init];
        _textures = [[NSMutableDictionary alloc] init];
    }
}

+ (NSMutableDictionary*)Shaders { return _shaders; }
+ (NSMutableDictionary*)Textures { return _textures; }


+ (Shader*) LoadShader:(NSString*) name 
    Vertex:(NSString*) vertex 
  Fragment:(NSString*) fragment 
{
    [_shaders setObject: [ResourceManager LoadShaderFromFile:vertex Fragment:fragment] forKey: name];
    return [_shaders objectForKey: name];
}

+ (Shader*) GetShader:(NSString*)name 
{
    return [_shaders objectForKey: name];
}

+ (Texture2D*) LoadTexture:(NSString*) name 
       Path:(NSString*) path 
      Alpha:(GLboolean) alpha 
{
    [_textures setObject: [ResourceManager LoadTextureFromFile:path Alpha:alpha] forKey: name];
    return [_shaders objectForKey: name];
}

+ (Texture2D*) GetTexture:(NSString*)name 
{
    return [_textures objectForKey: name];
}

+ (void) Clear 
{
    for (NSString *key in _textures) {
        Texture2D *texture = [_textures objectForKey:key];
        GL.DeleteTextures(1, texture.Id);
    }

    for (NSString *key in _shaders) {
        Shader *shader = [_shaders objectForKey:key];
        GL.DeleteProgram(shader.Id);
    }
}

+ (Shader*) LoadShaderFromFile:(NSString*) vertex 
          Fragment:(NSString*) fragment 
{

    let vertex_str = [[NSString alloc] 
        initWithData:[[NSData alloc]
        initWithContentsOfFile:vertex] encoding:NSUTF8StringEncoding];

    let fragment_str = [[NSString alloc] 
        initWithData:[[NSData alloc] 
        initWithContentsOfFile:fragment] encoding:NSUTF8StringEncoding];

    let shader = [[Shader alloc] init];
    [shader Compile:[vertex_str UTF8String] Fragment:[fragment_str UTF8String]];
    return shader;

}

+ (Texture2D*) LoadTextureFromFile:(NSString*) path 
              Alpha:(GLboolean) alpha 
{

    Texture2D* texture = [[Texture2D alloc] initWithPath:path Alpha:alpha];
    SDL_Surface* surface = IMG_Load([path UTF8String]);
    if (SDL_MUSTLOCK(surface)) 
        SDL_LockSurface(surface);
            
    [texture Generate:(unsigned char*)surface->pixels Width:surface->w Height:surface->h];

    if (SDL_MUSTLOCK(surface)) 
        SDL_UnlockSurface(surface);
    // And finally free image data
    SDL_FreeSurface(surface);
    return texture;
}


@end