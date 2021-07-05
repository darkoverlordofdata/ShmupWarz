#import "Shader.h"

@implementation Shader

@synthesize Id = mId;

- (instancetype)init { return [super init]; }
- (OFString*)description { return @"Shader"; }

/*
 * Use fluent interface for setters
 */
- (Shader*(^)(void))Use { 
    return ^Shader* (void) {
        GL.UseProgram(mId); 
        return self;
    };

}

- (Shader*(^)(const char* name, GLint value))SetInteger {
    return ^Shader* (const char* name, GLint value) {
        return [self setInteger:name Value:value UseShader:true];
    };
}

- (Shader*(^)(const char* name, GLfloat value))SetFloat {
    return ^Shader* (const char* name, GLfloat value) {
        return [self setFloat:name Value:value UseShader:true];
    };
}


- (Shader*(^)(const char* name, Vec2 value))SetVector2 {
    return ^Shader* (const char* name, Vec2 value) {
        return [self setVector2:name Value:value UseShader:true];
    };
}

- (Shader*(^)(const char* name, Vec3 value))SetVector3 {
    return ^Shader* (const char* name, Vec3 value) {
        return [self setVector3:name Value:value UseShader:true];
    };
}

- (Shader*(^)(const char* name, Mat value))SetMatrix4 {
    return ^Shader* (const char* name, Mat value) {
        return [self setMatrix4:name Value:value UseShader:true];
    };
}

- (void)
checkCompileErrors:(GLuint)object 
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
    [self checkCompileErrors:sVertex Type:@"VERTEX"];
    // Fragment Shader
    sFragment = GL.CreateShader(GL_FRAGMENT_SHADER);
    GL.ShaderSource(sFragment, 1, &fragmentSource, NULL);
    GL.CompileShader(sFragment);
    [self checkCompileErrors:sFragment Type:@"FRAGMENT"];

    // Shader Program
    mId = GL.CreateProgram();
    GL.AttachShader(mId, sVertex);
    GL.AttachShader(mId, sFragment);
    GL.LinkProgram(mId);
    [self checkCompileErrors:mId Type:@"PROGRAM"];
    // Delete the shaders as they're linked into our program now and no longer necessery
    GL.DeleteShader(sVertex);
    GL.DeleteShader(sFragment);

}

- (Shader*)use { 
    GL.UseProgram(mId); 
    return self;
}


- (Shader*)
setFloat:(const char*)name  
Value:(GLfloat)value 
{
    return [self setFloat:name Value:value UseShader:true];
}

- (Shader*)
setFloat:(const char*)name  
Value:(GLfloat)value  
UseShader:(GLboolean) useShader 
{
    if (useShader)
        [self use];
    GL.Uniform1f(GL.GetUniformLocation(mId, name), value);
    return self;
}

- (Shader*)
setInteger:(const char*)name  
Value:(GLint)value 
{
    return [self setInteger:name Value:value UseShader:true];
}

- (Shader*)
setInteger:(const char*)name  
Value:(GLint)value  
UseShader:(GLboolean) useShader 
{
    if (useShader)
        [self use];
    GL.Uniform1i(GL.GetUniformLocation(mId, name), value);
    return self;
}

- (Shader*)
setVector2:(const char*)name  
Value:(Vec2)value 
{
    return [self setVector2:name Value:value UseShader:true];
}

- (Shader*)
setVector2:(const char*)name  
Value:(Vec2)value  
UseShader:(GLboolean) useShader 
{
    if (useShader)
        [self use];
    GL.Uniform2f(GL.GetUniformLocation(mId, name), value.x, value.y);
    return self;
}

- (Shader*)
setVector3:(const char*)name  
Value:(Vec3)value 
{
    return [self setVector3:name Value:value UseShader:true];
}

- (Shader*)
setVector3:(const char*)name  
Value:(Vec3)value  
UseShader:(GLboolean) useShader 
{
    if (useShader)
        [self use];
    GL.Uniform3f(GL.GetUniformLocation(mId, name), value.x, value.y, value.z);
    return self;
}

- (Shader*)
setMatrix4:(const char*)name  
Value:(Mat)value 
{
    return [self setMatrix4:name Value:value UseShader:true];
}

- (Shader*)
setMatrix4:(const char*)name  
Value:(Mat)value  
UseShader:(GLboolean) useShader 
{
    if (useShader)
        [self use];
    GL.UniformMatrix4fv(glGetUniformLocation(mId, name), 1, GL_FALSE, (GLfloat*)&value);
    return self;
}


@end