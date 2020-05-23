#import "SpriteRenderer.h"

@implementation SpriteRenderer


- (instancetype)initWithShader:(Shader*)shader {
    if ((self = [super init])) {
        mShader = shader;
        [self InitRenderData];
    }
    return self;
}

- (void)dealloc {
    GL.DeleteVertexArrays(1, &mQuadVAO);
    // [super dealloc];
}

- (NSString*)description { return @"Shader"; }

- (void)
DrawSprite:(Texture2D*)texture 
    Bounds:(SDL_Rect)bounds
    Rotate:(GLfloat)rotate 
     Color:(Vec3)color 
{

    // Prepare transformations
    [mShader Use];
    Mat model= {
        1.0f, 0.0f, 0.0f, 0.0f,
        0.0f, 1.0f, 0.0f, 0.0f,
        0.0f, 0.0f, 1.0f, 0.0f,
        0.0f, 0.0f, 0.0f, 1.0f
    };
    //First translate (transformations are: scale happens first, then rotation and then finall translation happens; reversed order)
    static Vec3 zero = { 0, 0, 0 };
    static Vec3 tr = { 0, 0, 0 };
    static Vec3 sc = { 0, 0, 1 };
    tr.x = bounds.x;
    tr.y = bounds.y;
    model = glm_translate(model, tr);  // First translate (transformations are: scale happens first, then rotation and then finall translation happens; reversed order)
    tr.x = 0.5f * bounds.w;
    tr.y = 0.5f * bounds.h;
    model = glm_translate(model, tr); // Move origin of rotation to center of quad
    model = glm_rotate(model, rotate, zero); // Then rotate
    tr.x = -0.5f * bounds.w;
    tr.y = -0.5f * bounds.h;
    model = glm_translate(model, tr); // Move origin back
    sc.x = bounds.w;
    sc.y = bounds.h;
    model = glm_scale(model, sc); // Last scale

    mShader
    .SetMatrix4("model", model)
    .SetVector3("spriteColor", color);

    GL.ActiveTexture(GL_TEXTURE0);
    [texture Bind];

    GL.BindVertexArray(mQuadVAO);
    GL.DrawArrays(GL_TRIANGLES, 0, 6);
    GL.BindVertexArray(0);

}

- (void)InitRenderData {
    // Configure VAO/VBO
    GLuint VBO;
    GLfloat vertices[] = { 
        // Pos      // Tex
        0.0f, 1.0f, 0.0f, 1.0f,
        1.0f, 0.0f, 1.0f, 0.0f,
        0.0f, 0.0f, 0.0f, 0.0f, 

        0.0f, 1.0f, 0.0f, 1.0f,
        1.0f, 1.0f, 1.0f, 1.0f,
        1.0f, 0.0f, 1.0f, 0.0f
    };

    GL.GenVertexArrays(1, &mQuadVAO);
    GL.GenBuffers(1, &VBO);

    GL.BindBuffer(GL_ARRAY_BUFFER, VBO);
    GL.BufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    GL.BindVertexArray(mQuadVAO);
    GL.EnableVertexAttribArray(0);
    GL.VertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 4 * sizeof(GLfloat), (GLvoid*)0);
    GL.BindBuffer(GL_ARRAY_BUFFER, 0);
    GL.BindVertexArray(0);

}


@end