#version 300 es
#ifdef GL_ES
precision mediump float;
#else
precision highp float;
#endif

in vec2 TexCoords;
out vec4 color;

uniform sampler2D image;
uniform vec3 spriteColor;

void main()
{    
    color = vec4(spriteColor, 1.0) * texture(image, TexCoords);
}  