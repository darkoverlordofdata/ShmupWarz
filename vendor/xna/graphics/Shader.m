#import "Shader.h"

@implementation Shader

@synthesize Id = mId;

- (instancetype)init { return [super init]; }
- (OFString*)ToString { return @"Shader"; }
- (Shader*)Use { 
    GL.UseProgram(mId); 
    return self;
}

- (void)
CheckCompileErrors:(GLuint)object 
              Type:(OFString*)type 
{
    GLint success;
    GLchar infoLog[1024];
    if (type != @"PROGRAM")
    {
        GL.GetShaderiv(object, GL_COMPILE_STATUS, &success);
        if (!success)
        {
            GL.GetShaderInfoLog(object, 1024, NULL, infoLog);
            OFLog("| ERROR::Shader: Compile-time error: Type: %s\n%s\n -- --------------------------------------------------- -- ",
                [type UTF8String], infoLog);
        }
    }
    else
    {
        GL.GetProgramiv(object, GL_LINK_STATUS, &success);
        if (!success)
        {
            GL.GetProgramInfoLog(object, 1024, NULL, infoLog);
            OFLog("| ERROR::Shader: Link-time error: Type: %s\n%s\n -- --------------------------------------------------- -- ",
            [type UTF8String], infoLog);
        }
    }
}

- (void)
Compile:(const char*) vertexSource 
Fragment:(const char*) fragmentSource 
{
    GLuint sVertex, sFragment;
    // Vertex Shader
    sVertex = GL.CreateShader(GL_VERTEX_SHADER);
    GL.ShaderSource(sVertex, 1, &vertexSource, NULL);
    GL.CompileShader(sVertex);
    [self CheckCompileErrors:sVertex Type:@"VERTEX"];
    // Fragment Shader
    sFragment = GL.CreateShader(GL_FRAGMENT_SHADER);
    GL.ShaderSource(sFragment, 1, &fragmentSource, NULL);
    GL.CompileShader(sFragment);
    [self CheckCompileErrors:sFragment Type:@"FRAGMENT"];

    // Shader Program
    mId = GL.CreateProgram();
    GL.AttachShader(mId, sVertex);
    GL.AttachShader(mId, sFragment);
    GL.LinkProgram(mId);
    [self CheckCompileErrors:mId Type:@"PROGRAM"];
    // Delete the shaders as they're linked into our program now and no longer necessery
    GL.DeleteShader(sVertex);
    GL.DeleteShader(sFragment);

}

- (Shader*)
SetFloat:(const char*)name  
Value:(GLfloat)value 
{
    return [self SetFloat:name Value:value UseShader:true];
}

- (Shader*)
SetFloat:(const char*)name  
Value:(GLfloat)value  
UseShader:(GLboolean) useShader 
{
    if (useShader)
        [self Use];
    GL.Uniform1f(GL.GetUniformLocation(mId, name), value);
    return self;
}

- (Shader*)
SetInteger:(const char*)name  
Value:(GLint)value 
{
    return [self SetInteger:name Value:value UseShader:true];
}

- (Shader*)
SetInteger:(const char*)name  
Value:(GLint)value  
UseShader:(GLboolean) useShader 
{
    if (useShader)
        [self Use];
    GL.Uniform1i(GL.GetUniformLocation(mId, name), value);
    return self;
}

- (Shader*)
SetVector2:(const char*)name  
Value:(Vec2)value 
{
    return [self SetVector2:name Value:value UseShader:true];
}

- (Shader*)
SetVector2:(const char*)name  
Value:(Vec2)value  
UseShader:(GLboolean) useShader 
{
    if (useShader)
        [self Use];
    GL.Uniform2f(GL.GetUniformLocation(mId, name), value.x, value.y);
    return self;
}

- (Shader*)
SetVector3:(const char*)name  
Value:(Vec3)value 
{
    return [self SetVector3:name Value:value UseShader:true];
}

- (Shader*)
SetVector3:(const char*)name  
Value:(Vec3)value  
UseShader:(GLboolean) useShader 
{
    if (useShader)
        [self Use];
    GL.Uniform3f(GL.GetUniformLocation(mId, name), value.x, value.y, value.z);
    return self;
}

- (Shader*)
SetMatrix4:(const char*)name  
Value:(Mat)value 
{
    return [self SetMatrix4:name Value:value UseShader:true];
}

- (Shader*)
SetMatrix4:(const char*)name  
Value:(Mat)value  
UseShader:(GLboolean) useShader 
{
    if (useShader)
        [self Use];
    GL.UniformMatrix4fv(glGetUniformLocation(mId, name), 1, GL_FALSE, (GLfloat*)&value);
    return self;
}


@end