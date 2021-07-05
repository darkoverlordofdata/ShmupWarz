#import <Foundation/Foundation.h>
#import <SDL2/SDL.h>
#import "../OpenGL.h"

@interface Texture2D : OFObject  
{
    // Holds the ID of the texture object, used for all texture operations to reference to this particlar texture
    GLuint mId;
    // Texture image dimensions
    GLuint mWidth;
    GLuint mHeight; // Width and height of loaded image in pixels
    // Texture Format
    GLuint mInternalFormat; // Format of texture object
    GLuint mImageFormat; // Format of loaded image

    GLuint mWrapS; // Wrapping mode on S axis
    GLuint mWrapT; // Wrapping mode on T axis
    GLuint mFilterMin; // Filtering mode if texture pixels < screen pixels
    GLuint mFilterMag; // Filtering mode if texture pixels > screen pixels
    OFString* mPath;

}
@property (nonatomic, assign) GLuint Id;
@property (nonatomic, assign) GLuint Width;
@property (nonatomic, assign) GLuint Height;
@property (nonatomic, assign) GLuint InternalFormat;
@property (nonatomic, assign) GLuint ImageFormat;

- (instancetype)initWithPath:(OFString*)path;
- (instancetype)initWithPath:(OFString*)path 
Alpha:(bool)alpha;
- (OFString*)description;
- (void)Generate:(unsigned char*)pixels 
Width:(GLuint)width 
Height:(GLuint)height;
- (void)Bind;

@end