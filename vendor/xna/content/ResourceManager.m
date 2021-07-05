#import "ResourceManager.h"

@implementation ResourceManager;

static OFMutableDictionary* _shaders = nil;
static OFMutableDictionary* _textures = nil;

+ (void) initialize {
    if (self == [ResourceManager class]) {
        _shaders = [[OFMutableDictionary alloc] init];
        _textures = [[OFMutableDictionary alloc] init];
    }
}

+ (OFMutableDictionary*)Shaders { return _shaders; }
+ (OFMutableDictionary*)Textures { return _textures; }


+ (Shader*) LoadShader:(OFString*) name 
    Vertex:(OFString*) vertex 
  Fragment:(OFString*) fragment 
{
    [_shaders setObject: [ResourceManager LoadShaderFromFile:vertex Fragment:fragment] forKey: name];
    return [_shaders objectForKey: name];
}

+ (Shader*) GetShader:(OFString*)name 
{
    return [_shaders objectForKey: name];
}

+ (Texture2D*) LoadTexture:(OFString*) name 
       Path:(OFString*) path 
      Alpha:(GLboolean) alpha 
{
    [_textures setObject: [ResourceManager LoadTextureFromFile:path Alpha:alpha] forKey: name];
    return [_shaders objectForKey: name];
}

+ (Texture2D*) GetTexture:(OFString*)name 
{
    return [_textures objectForKey: name];
}

+ (void) Clear 
{
    for (OFString *key in _textures) {
        Texture2D *texture = [_textures objectForKey:key];
        GL.DeleteTextures(1, texture.Id);
    }

    for (OFString *key in _shaders) {
        Shader *shader = [_shaders objectForKey:key];
        GL.DeleteProgram(shader.Id);
    }
}

+ (Shader*) LoadShaderFromFile:(OFString*) vertex 
          Fragment:(OFString*) fragment 
{

    let vertex_str = [[OFString alloc] 
        initWithData:[[OFData alloc]
        initWithContentsOfFile:vertex] encoding:OF_STRING_ENCODING_UTF_8];

    let fragment_str = [[OFString alloc] 
        initWithData:[[OFData alloc] 
        initWithContentsOfFile:fragment] encoding:OF_STRING_ENCODING_UTF_8];

    let shader = [[Shader alloc] init];
    [shader Compile:[vertex_str UTF8String] Fragment:[fragment_str UTF8String]];
    return shader;

}

+ (Texture2D*) LoadTextureFromFile:(OFString*) path 
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