#import <Foundation/Foundation.h>
#import <SDL2/SDL.h>
#import <tglm/tglm.h>
#import "../OpenGL.h"

@interface Shader : OFObject  
{
    GLuint mId; 
}
@property (nonatomic, assign) GLuint Id;

@property (readonly, nonatomic, copy) Shader* (^Use)(void);
@property (readonly, nonatomic, copy) Shader* (^SetInteger)(char* name, GLint value);
@property (readonly, nonatomic, copy) Shader* (^SetFloat)(char* name, GLfloat value);
@property (readonly, nonatomic, copy) Shader* (^SetVector2)(char* name, Vec2 value);
@property (readonly, nonatomic, copy) Shader* (^SetVector3)(char* name, Vec3 value);
@property (readonly, nonatomic, copy) Shader* (^SetMatrix4)(char* name, Mat value);

- (instancetype)init;
- (OFString*)description;
- (Shader*)use;
- (void)checkCompileErrors:(GLuint)object Type:(OFString*)type;
- (void)Compile:(const char*) vertexSource Fragment:(const char*) fragmentSource;
- (Shader*)setInteger:(const char*)name  Value:(GLint)value;
- (Shader*)setInteger:(const char*)name  Value:(GLint)value  UseShader:(GLboolean) useShader;
- (Shader*)setFloat:(const char*)name  Value:(GLfloat)value;
- (Shader*)setFloat:(const char*)name  Value:(GLfloat)value  UseShader:(GLboolean) useShader;
- (Shader*)setVector2:(const char*)name  Value:(Vec2)value;
- (Shader*)setVector2:(const char*)name  Value:(Vec2)value  UseShader:(GLboolean) useShader;
- (Shader*)setVector3:(const char*)name  Value:(Vec3)value;
- (Shader*)setVector3:(const char*)name  Value:(Vec3)value  UseShader:(GLboolean) useShader;
- (Shader*)setMatrix4:(const char*)name  Value:(Mat)value;
- (Shader*)setMatrix4:(const char*)name  Value:(Mat)value  UseShader:(GLboolean) useShader;

@end