#version 300 es
#ifdef GL_ES
precision mediump float;
#else
precision highp float;
#endif

in vec2 TexCoords;
in vec4 ParticleColor;
out vec4 color;

uniform sampler2D sprite;

void main()
{
    color = (texture(sprite, TexCoords) * ParticleColor);
}  