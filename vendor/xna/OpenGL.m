#import "OpenGL.h"
extern OpenGL GL;
OpenGL GL;

void SDL_GL_InitContext(SDL_Window *window)
{
    const OpenGL api = (OpenGL) {
        .context = SDL_GL_CreateContext(window),
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
    // load api into global scope
    memcpy(&GL, &api, sizeof(OpenGL));
}
