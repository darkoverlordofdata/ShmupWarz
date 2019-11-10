#import <Foundation/Foundation.h>
#import <OpenGL.h>
#import <SDL2/SDL.h>
#import <tglm/tglm.h>

@interface Shader : OFObject  
{
    GLuint mId; 
}
@property (nonatomic, assign) GLuint Id;

- (instancetype)init;
- (OFString*)ToString;
- (Shader*)Use;
- (void)CheckCompileErrors:(GLuint)object Type:(OFString*)type;
- (void)Compile:(const char*) vertexSource Fragment:(const char*) fragmentSource;
- (Shader*)SetInteger:(const char*)name  Value:(GLint)value;
- (Shader*)SetInteger:(const char*)name  Value:(GLint)value  UseShader:(GLboolean) useShader;
- (Shader*)SetFloat:(const char*)name  Value:(GLfloat)value;
- (Shader*)SetFloat:(const char*)name  Value:(GLfloat)value  UseShader:(GLboolean) useShader;
- (Shader*)SetVector2:(const char*)name  Value:(Vec2)value;
- (Shader*)SetVector2:(const char*)name  Value:(Vec2)value  UseShader:(GLboolean) useShader;
- (Shader*)SetVector3:(const char*)name  Value:(Vec3)value;
- (Shader*)SetVector3:(const char*)name  Value:(Vec3)value  UseShader:(GLboolean) useShader;
- (Shader*)SetMatrix4:(const char*)name  Value:(Mat)value;
- (Shader*)SetMatrix4:(const char*)name  Value:(Mat)value  UseShader:(GLboolean) useShader;

@end