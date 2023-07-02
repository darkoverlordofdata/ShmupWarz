#import "Game.h"
extern OpenGL GL;
// OpenGL GL;

/**
 *  MACRO Min
 *      cache results of calculation in pocket scope 
 */
#define Min(a, b)                                                       \
({                                                                      \
    const __auto_type _a = a;                                           \
    const __auto_type _b = b;                                           \
    (_a < _b) ? _a : _b;                                                \
})

/**
 *  MACRO Max
 *      cache results of calculation in pocket scope 
 */
#define Max(a, b)                                                       \
({                                                                      \
    const __auto_type _a = a;                                           \
    const __auto_type _b = b;                                           \
    (_a > _b) ? _a : _b;                                                \
})

// void SDL_GL_InitContext(SDL_Window *window);

static inline uint64_t GetTicks() { 
    static struct timeval t = { .tv_sec = 0, .tv_usec = 0 };
    
    gettimeofday(&t, NULL);
    uint64_t ts = t.tv_sec;
    uint64_t us = t.tv_usec;
    return ((ts * 1000000L) + us) * 10;
}

@implementation Game

// @synthesize Keys = mKeys;
@synthesize Delta = mDelta;
@synthesize IsRunning = mIsRunning;
@synthesize MouseDown = mMouseDown;
@synthesize MouseX = mMouseX;
@synthesize MouseY = mMouseY;
@synthesize Width = mWidth;
@synthesize Height = mHeight;
@synthesize Window = mWindow;
@synthesize Title = mTitle;


/**
 * Create Game instance
 * 
 * @param Width of screen
 * @param Height of screen
 * 
 */
- (instancetype)initWithTitle:(NSString*)title
                        Width:(int)width 
                        Height:(int)height 
{
    if ((self = [super init])) {
        mWidth = width;
        mHeight = height;
        mTitle = title;
        mIsRunning = false;
        mPreviousTicks = 0;
        mIsFixedTimeStep = true;
        mShouldExit = false;
        mSuppressDraw = false;
        mMaxElapsedTime = 500 * TicksPerMillisecond;
        mTargetElapsedTime = 166667;
        mAccumulatedElapsedTime = 0;
        [self CreatePlatform];
    }
    return self;
}

- (void)CreatePlatform {
    SDL_Init(SDL_INIT_VIDEO);
    SDL_SetHint("SDL_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR", "0");

    mWindow = SDL_CreateWindow([mTitle UTF8String],
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        mWidth,
        mHeight,
        SDL_WINDOW_RESIZABLE | 
        SDL_WINDOW_SHOWN |
        SDL_WINDOW_OPENGL
    );


    SDL_GL_InitContext(mWindow);

    int imgFlags = IMG_INIT_PNG;
    if( !( IMG_Init( imgFlags ) & imgFlags ) )
    {
        printf( "SDL_image could not initialize! SDL_image Error: %s\n", IMG_GetError() );
        // success = false;
    }

    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);
    SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
    SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);

    SDL_GL_SetSwapInterval(1);

    GL.Viewport(0, 0, mWidth, mHeight);
    GL.Enable(GL_CULL_FACE);
    GL.Enable(GL_BLEND);
    GL.BlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

}

- (NSString*)ToString { return @"Game"; }

/**
 * Start
 */
- (void)Start {
    mIsRunning = true;
}

/**
 * Stop
 */
- (void)Stop {
}

/**
 * Quit
 */
- (void)Quit {
    mIsRunning = false;
    [self Stop];
}

- (void)Initialize {}
- (void)LoadContent {}
- (void)Update:(GLfloat) delta {}
- (void)Draw:(GLfloat) delta {
    // GL.ClearColor(1.0f, 0.0f, 0.0f, 1.0f);
    // GL.Clear(GL_COLOR_BUFFER_BIT);
}

- (bool)GetKey:(int)Key {
    return mKeys[Key & SCAN_MASK];
}

/**
 * Run
 */
- (void)Run {

    [self Initialize];
    [self LoadContent];
    [self Start];

    while (mIsRunning) {
        [self RunLoop];
    }
}

/**
 * RunLoop
 */
- (void)RunLoop {
    [self HandleEvents];
    [self Tick];
}

/**
 * Handle events
 */
- (void)HandleEvents {
    SDL_Event event;
    while (SDL_PollEvent(&event) != 0) {
        
        switch (event.type) {

            case SDL_QUIT:
                mIsRunning = false;
                [self Quit];       
                break;

            case SDL_KEYDOWN: 
                mKeys[ event.key.keysym.scancode & SCAN_MASK ] = true;
                if (event.key.keysym.sym == SDLK_ESCAPE) {
                    [self Quit];       
                    return;     
                }
                break;
            case SDL_KEYUP:   
                mKeys[ event.key.keysym.scancode & SCAN_MASK ] = false;
                break;
            case SDL_MOUSEBUTTONDOWN:
                mMouseDown = true;
                break;
            case SDL_MOUSEBUTTONUP:
                mMouseDown = false;
                break;
            case SDL_MOUSEMOTION:
                mMouseX = event.motion.x;
                mMouseY = event.motion.y;
                break;


            default: break;
        }
    }
}

/**
 * Tick
 */
- (void)Tick {

    while (true)
    {
        // Advance the accumulated elapsed time.
        long currentTicks = GetTicks() - mCurrentTime; // ?? SDL_GetTicks ??
        mAccumulatedElapsedTime = mAccumulatedElapsedTime + currentTicks - mPreviousTicks;
        mPreviousTicks = (long)currentTicks;

        // If we're in the fixed timestep mode and not enough time has elapsed
        // to perform an update we sleep off the the remaining time to save battery
        // life and/or release CPU time to other threads and processes.
        if (mIsFixedTimeStep && mAccumulatedElapsedTime < mTargetElapsedTime)
        {
            int sleepTime = (int)((mTargetElapsedTime - mAccumulatedElapsedTime) * MillisecondsPerTick );
            if (sleepTime < 1) break;
            // NOTE: While sleep can be inaccurate in general it is 
            // accurate enough for frame limiting purposes if some
            // fluctuation is an acceptable result.
            SDL_Delay(sleepTime);
            // usleep(sleepTime*1000);

            // goto RetryTick;
        }
        else break;
    }
    // Do not allow any update to take longer than our maximum.
    if (mAccumulatedElapsedTime > mMaxElapsedTime)
        mAccumulatedElapsedTime = mMaxElapsedTime;

    if (mIsFixedTimeStep)
    {
        mElapsedGameTime = mTargetElapsedTime;
        int stepCount = 0;

        // Perform as many full fixed length time steps as we can.
        while (mAccumulatedElapsedTime >= mTargetElapsedTime && !mShouldExit)
        {
            mTotalGameTime += mTargetElapsedTime;
            mAccumulatedElapsedTime -= mTargetElapsedTime;
            ++stepCount;
            mDelta = (double)mElapsedGameTime * SecondsPerTick;
            [self Update:mDelta];
            // DoUpdate(&mGameTime);
        }
        //Every update after the first accumulates lag
        mUpdateFrameLag += Max(0, stepCount - 1);
        //If we think we are running slowly, wait until the lag clears before resetting it
        if (mIsRunningSlowly)
        {
            if (mUpdateFrameLag == 0)
            
                mIsRunningSlowly = false;
        }
        else if (mUpdateFrameLag >= 5)
        {
            //If we lag more than 5 frames, start thinking we are running slowly
            mIsRunningSlowly = true;
        }
        //Every time we just do one update and one draw, then we are not running slowly, so decrease the lag
        if (stepCount == 1 && mUpdateFrameLag > 0)
            mUpdateFrameLag--;

        // Draw needs to know the total elapsed time
        // that occured for the fixed length updates.
        mElapsedGameTime = mTargetElapsedTime * stepCount;

    }
    else
    {
        // Perform a single variable length update.
        mElapsedGameTime = mAccumulatedElapsedTime;
        mTotalGameTime += mAccumulatedElapsedTime;
        mAccumulatedElapsedTime = 0; 

        // Update();
        [self Update:mDelta];
    }

    // Draw unless the update suppressed it.
    if (mSuppressDraw)
        mSuppressDraw = false;
    else
    {
        // Draw();
        [self Draw:mDelta];
    }

    if (mShouldExit) mIsRunning = false;
        // Platform.Exit();

}


/**
 * Release game resources
 */
- (void)Dispose {
    SDL_GL_DeleteContext(GL.context);  
    SDL_DestroyWindow(mWindow);
    SDL_Quit();
}


@end

// void SDL_GL_InitContext(SDL_Window *window)
// {
//     const OpenGL api = (OpenGL) {
//         .context = SDL_GL_CreateContext(window),
//         .DeleteProgram = SDL_GL_GetProcAddress("glDeleteProgram"),
//         .DeleteTextures = SDL_GL_GetProcAddress("glDeleteTextures"),
//         .GenVertexArrays = SDL_GL_GetProcAddress("glGenVertexArrays"),
//         .EnableVertexAttribArray = SDL_GL_GetProcAddress("glEnableVertexAttribArray"),
//         .VertexAttribPointer = SDL_GL_GetProcAddress("glVertexAttribPointer"),
//         .BindVertexArray = SDL_GL_GetProcAddress("glBindVertexArray"),
//         .ActiveTexture = SDL_GL_GetProcAddress("glActiveTexture"),
//         .DeleteVertexArrays = SDL_GL_GetProcAddress("glDeleteVertexArrays"),
//         .CreateShader = SDL_GL_GetProcAddress("glCreateShader"),
//         .ShaderSource = SDL_GL_GetProcAddress("glShaderSource"),
//         .CompileShader = SDL_GL_GetProcAddress("glCompileShader"),
//         .GetShaderiv = SDL_GL_GetProcAddress("glGetShaderiv"),
//         .GetShaderInfoLog = SDL_GL_GetProcAddress("glGetShaderInfoLog"),
//         .GetProgramiv = SDL_GL_GetProcAddress("glGetProgramiv"),
//         .GetProgramInfoLog = SDL_GL_GetProcAddress("glGetProgramInfoLog"),
//         .CreateProgram = SDL_GL_GetProcAddress("glCreateProgram"),
//         .AttachShader = SDL_GL_GetProcAddress("glAttachShader"),
//         .DetachShader = SDL_GL_GetProcAddress("glDetachShader"),
//         .LinkProgram = SDL_GL_GetProcAddress("glLinkProgram"),
//         .DeleteShader = SDL_GL_GetProcAddress("glDeleteShader"),
//         .Uniform1i = SDL_GL_GetProcAddress("glUniform1i"),
//         .Uniform1f = SDL_GL_GetProcAddress("glUniform1f"),
//         .Uniform2f = SDL_GL_GetProcAddress("glUniform2f"),
//         .Uniform2fv = SDL_GL_GetProcAddress("glUniform2fv"),
//         .Uniform3f = SDL_GL_GetProcAddress("glUniform3f"),
//         .Uniform3fv = SDL_GL_GetProcAddress("glUniform3fv"),
//         .Uniform4f = SDL_GL_GetProcAddress("glUniform4f"),
//         .Uniform4fv = SDL_GL_GetProcAddress("glUniform4fv"),
//         .UniformMatrix4fv = SDL_GL_GetProcAddress("glUniformMatrix4fv"),
//         .GetUniformLocation = SDL_GL_GetProcAddress("glGetUniformLocation"),
//         .UseProgram = SDL_GL_GetProcAddress("glUseProgram"),
//         .GenerateMipmap = SDL_GL_GetProcAddress("glGenerateMipmap"),
//         .TexImage2D = SDL_GL_GetProcAddress("glTexImage2D"),
//         .GenTextures = SDL_GL_GetProcAddress("glGenTextures"),
//         .Viewport = SDL_GL_GetProcAddress("glViewport"),
//         .GetError = SDL_GL_GetProcAddress("glGetError"),
//         .TexParameteri = SDL_GL_GetProcAddress("glTexParameteri"),
//         .Clear = SDL_GL_GetProcAddress("glClear"),
//         .ClearColor = SDL_GL_GetProcAddress("glClearColor"),
//         .BindTexture = SDL_GL_GetProcAddress("glBindTexture"),
//         .Enable = SDL_GL_GetProcAddress("glEnable"),
//         .Disable = SDL_GL_GetProcAddress("glDisable"),
//         .GenBuffers = SDL_GL_GetProcAddress("glGenBuffers"),
//         .BufferData = SDL_GL_GetProcAddress("glBufferData"),
//         .BufferSubData = SDL_GL_GetProcAddress("glBufferSubData"),
//         .DeleteBuffers = SDL_GL_GetProcAddress("glDeleteBuffers"),
//         .BindBuffer = SDL_GL_GetProcAddress("glBindBuffer"),
//         .DrawElements = SDL_GL_GetProcAddress("glDrawElements"),
//         .DrawArrays = SDL_GL_GetProcAddress("glDrawArrays"),
//         .BlendFunc = SDL_GL_GetProcAddress("glBlendFunc")
//     };
//     // load api into global scope
//     memcpy(&GL, &api, sizeof(OpenGL));
// }
