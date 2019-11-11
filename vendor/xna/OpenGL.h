/* ******************************************************************************
 * 
 * Copyright (c) 2019, Dark Overlord of Data
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *    * Neither the name of the <organization> nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
******************************************************************************/
#import <Foundation/Foundation.h>
#import <GL/gl.h>
#import <SDL2/SDL.h>
/*
 * OpenGL Loader
 */
typedef struct OpenGL OpenGL;   
extern OpenGL GL;
OpenGL GL;

typedef struct OpenGL {
    
    const SDL_GLContext context;
    const void (*BindTexture) (GLenum target, GLuint id);
    const void (*BindBuffer) (GLenum target, GLuint buffer);
    const void (*Clear) (GLbitfield mask);
    const void (*ClearColor) (GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
    const void (*GenBuffers) (GLsizei count, GLuint* buffers);
    const void (*BufferData) (GLenum target, GLsizeiptr size, const GLvoid* data, GLenum usage);
    const void (*BufferSubData) (GLenum target, GLintptr offset, GLsizeiptr size, const GLvoid* data);
    const void (*DeleteBuffers) (GLsizei count, GLuint* buffers);
    const void (*DrawElements) (GLenum mode, GLsizei count, GLenum type, const GLvoid* indices);
    const void (*TexParameteri) (GLenum target, GLenum name, GLint value);
    const void (*DrawArrays) (GLenum mode, GLint first, GLsizei count);
    const GLint (*Enable) (GLenum cap);
    const GLint (*Disable) (GLenum cap);
    const GLint (*BlendFunc) (GLenum sfactor, GLenum dfactor);
    const GLenum (*GetError) (void);
    const void (*Viewport) (GLint x, GLint y, GLsizei w, GLsizei h);
    const void (*GenTextures) (GLsizei n, GLuint* textures);
    const void (*TexImage2D) (GLenum target, GLint level, GLint internalFormat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum pixelType, const GLvoid* data);
    const void (*GenerateMipmap) (GLenum target);
    const void (*UseProgram) (GLuint program);
    const GLuint (*CreateShader) (GLenum shaderType);
    const void (*ShaderSource) (GLuint shader, GLsizei count, const GLchar** string, const GLint* length);
    const void (*CompileShader) (GLuint shader);
    const void (*GetShaderiv) (GLuint shader, GLenum pname, GLint* params);
    const void (*GetShaderInfoLog) (GLuint shader, GLsizei maxLength, GLsizei* length, GLchar* infoLog);
    const void (*GetProgramiv) (GLuint program, GLenum pname, GLint* params);
    const void (*GetProgramInfoLog) (GLuint program, GLsizei maxLength, GLsizei* length, GLchar* infoLog);
    const GLuint (*CreateProgram) (void);
    const void (*AttachShader) (GLuint program, GLuint shader);
    const void (*DetachShader) (GLuint program, GLuint shader);
    const void (*LinkProgram) (GLuint program);
    const void (*DeleteShader) (GLuint shader);
    const void (*Uniform1i) (GLint location, GLint v0);
    const void (*Uniform1f) (GLint location, GLfloat v0);
    const void (*Uniform2f) (GLint location, GLfloat v0, GLfloat v1);
    const void (*Uniform2fv) (GLint location, GLsizei count, const GLfloat* value);
    const void (*Uniform3f) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
    const void (*Uniform3fv) (GLint location, GLsizei count, const GLfloat* value);
    const void (*Uniform4f) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
    const void (*Uniform4fv) (GLint location, GLsizei count, const GLfloat* value);
    const void (*UniformMatrix4fv) (GLint location, GLsizei count, GLboolean transpose, const GLfloat* value);
    const GLint (*GetUniformLocation) (GLuint program, const GLchar* name);
    const void (*GenVertexArrays) (GLsizei n, GLuint* arrays);
    const void (*EnableVertexAttribArray) (GLuint index);
    const void (*VertexAttribPointer) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid* pointer);
    const void (*BindVertexArray) (GLuint array);
    const void (*ActiveTexture) (GLenum texture);
    const void (*DeleteVertexArrays) (GLsizei n, const GLuint* arrays);
    const void (*DeleteProgram) (GLuint program);
    const void (*DeleteTextures) (GLsizei n, const GLuint* textures);

} OpenGL;


static inline void SDL_GL_InitContext(SDL_Window *window)
{
    let gl = (OpenGL) {
        .context = SDL_GL_CreateContext(window),
        .DeleteProgram = SDL_GL_GetProcAddress("glDeleteProgram"),
        .DeleteProgram = SDL_GL_GetProcAddress("glDeleteProgram"),
        .DeleteTextures = SDL_GL_GetProcAddress("glDeleteTextures"),
        .GenVertexArrays = SDL_GL_GetProcAddress("glGenVertexArrays"),
        .EnableVertexAttribArray = SDL_GL_GetProcAddress("glEnableVertexAttribArray"),
        .VertexAttribPointer = SDL_GL_GetProcAddress("glVertexAttribPointer"),
        .BindVertexArray = SDL_GL_GetProcAddress("glBindVertexArray"),
        .ActiveTexture = SDL_GL_GetProcAddress("glActiveTexture"),
        .DeleteVertexArrays = SDL_GL_GetProcAddress("glDeleteVertexArrays"),
        .CreateShader = SDL_GL_GetProcAddress("glCreateShader"),
        .ShaderSource = SDL_GL_GetProcAddress("glShaderSource"),
        .CompileShader = SDL_GL_GetProcAddress("glCompileShader"),
        .GetShaderiv = SDL_GL_GetProcAddress("glGetShaderiv"),
        .GetShaderInfoLog = SDL_GL_GetProcAddress("glGetShaderInfoLog"),
        .GetProgramiv = SDL_GL_GetProcAddress("glGetProgramiv"),
        .GetProgramInfoLog = SDL_GL_GetProcAddress("glGetProgramInfoLog"),
        .CreateProgram = SDL_GL_GetProcAddress("glCreateProgram"),
        .AttachShader = SDL_GL_GetProcAddress("glAttachShader"),
        .DetachShader = SDL_GL_GetProcAddress("glDetachShader"),
        .LinkProgram = SDL_GL_GetProcAddress("glLinkProgram"),
        .DeleteShader = SDL_GL_GetProcAddress("glDeleteShader"),
        .Uniform1i = SDL_GL_GetProcAddress("glUniform1i"),
        .Uniform1f = SDL_GL_GetProcAddress("glUniform1f"),
        .Uniform2f = SDL_GL_GetProcAddress("glUniform2f"),
        .Uniform2fv = SDL_GL_GetProcAddress("glUniform2fv"),
        .Uniform3f = SDL_GL_GetProcAddress("glUniform3f"),
        .Uniform3fv = SDL_GL_GetProcAddress("glUniform3fv"),
        .Uniform4f = SDL_GL_GetProcAddress("glUniform4f"),
        .Uniform4fv = SDL_GL_GetProcAddress("glUniform4fv"),
        .UniformMatrix4fv = SDL_GL_GetProcAddress("glUniformMatrix4fv"),
        .GetUniformLocation = SDL_GL_GetProcAddress("glGetUniformLocation"),
        .UseProgram = SDL_GL_GetProcAddress("glUseProgram"),
        .GenerateMipmap = SDL_GL_GetProcAddress("glGenerateMipmap"),
        .TexImage2D = SDL_GL_GetProcAddress("glTexImage2D"),
        .GenTextures = SDL_GL_GetProcAddress("glGenTextures"),
        .Viewport = SDL_GL_GetProcAddress("glViewport"),
        .GetError = SDL_GL_GetProcAddress("glGetError"),
        .TexParameteri = SDL_GL_GetProcAddress("glTexParameteri"),
        .Clear = SDL_GL_GetProcAddress("glClear"),
        .ClearColor = SDL_GL_GetProcAddress("glClearColor"),
        .BindTexture = SDL_GL_GetProcAddress("glBindTexture"),
        .Enable = SDL_GL_GetProcAddress("glEnable"),
        .Disable = SDL_GL_GetProcAddress("glDisable"),
        .GenBuffers = SDL_GL_GetProcAddress("glGenBuffers"),
        .BufferData = SDL_GL_GetProcAddress("glBufferData"),
        .BufferSubData = SDL_GL_GetProcAddress("glBufferSubData"),
        .DeleteBuffers = SDL_GL_GetProcAddress("glDeleteBuffers"),
        .BindBuffer = SDL_GL_GetProcAddress("glBindBuffer"),
        .DrawElements = SDL_GL_GetProcAddress("glDrawElements"),
        .DrawArrays = SDL_GL_GetProcAddress("glDrawArrays"),
        .BlendFunc = SDL_GL_GetProcAddress("glBlendFunc")
    };
    memcpy(&GL, &gl, sizeof(OpenGL));
}