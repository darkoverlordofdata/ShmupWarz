#import "Texture2D.h"

@implementation Texture2D

@synthesize Id = mId;
@synthesize Width = mWidth;
@synthesize Height = mHeight;
@synthesize InternalFormat = mInternalFormat;
@synthesize ImageFormat = mImageFormat;

- (instancetype)initWithPath:(NSString*)path { return [self initWithPath:path Alpha:true]; }

- (instancetype)
initWithPath:(NSString*)path 
       Alpha:(bool)alpha 
{
    if ((self = [super init])) {
        mPath = path;
        mInternalFormat = alpha ? GL_RGBA : GL_RGB;
        mImageFormat = alpha ? GL_RGBA : GL_RGB;
        mWrapS = GL_REPEAT;
        mWrapT = GL_REPEAT;
        mFilterMin = GL_LINEAR;
        mFilterMag = GL_LINEAR;
        GL.GenTextures(1, &mId);
    }
    return self;
}

- (NSString*)description { return @"Texture2D"; }
- (void)Bind { GL.BindTexture(GL_TEXTURE_2D, mId); }

- (void)
Generate:(unsigned char*)pixels 
   Width:(GLuint)width 
  Height:(GLuint)height 
{
    mWidth = width;
    mHeight = height;
    // Create Texture
    GL.BindTexture(GL_TEXTURE_2D, mId);
    GL.TexImage2D(GL_TEXTURE_2D, 0, mInternalFormat, width, height, 0, mImageFormat, GL_UNSIGNED_BYTE, pixels);
    // Set Texture wrap and filter modes
    GL.TexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, mWrapS);
    GL.TexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, mWrapT);
    GL.TexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, mFilterMin);
    GL.TexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, mFilterMag);
    // Unbind texture
    GL.BindTexture(GL_TEXTURE_2D, 0);
}


@end