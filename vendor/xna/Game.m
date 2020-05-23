#import "Game.h"

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
- (instancetype)initWithWidth:(int)width 
                       Height:(int)height 
{
    if ((self = [super init])) {
        mWidth = width;
        mHeight = height;
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

    mWindow = SDL_CreateWindow("ObjFW SDL2",
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        mWidth,
        mHeight,
        SDL_WINDOW_RESIZABLE | 
        SDL_WINDOW_SHOWN |
        SDL_WINDOW_OPENGL
    );


    SDL_GL_InitContext(mWindow);
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

- (NSString*)description { return @"Game"; }

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
- (void)Draw:(GLfloat) delta {}

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
        long currentTicks = GetTicks() - mCurrentTime;
        mAccumulatedElapsedTime = mAccumulatedElapsedTime + currentTicks - mPreviousTicks;
        mPreviousTicks = (long)currentTicks;

        // If we're in the fixed timestep mode and not enough time has elapsed
        // to perform an update we sleep NSf the the remaining time to save battery
        // life and/or release CPU time to other threads and processes.
        if (mIsFixedTimeStep && mAccumulatedElapsedTime < mTargetElapsedTime)
        {
            int sleepTime = (int)((mTargetElapsedTime - mAccumulatedElapsedTime) * MillisecondsPerTick );
            if (sleepTime < 1) break;
            // NOTE: While sleep can be inaccurate in general it is 
            // accurate enough for frame limiting purposes if some
            // fluctuation is an acceptable result.
            // SDL_Delay(sleepTime);
            usleep(sleepTime*1000);
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
        auto stepCount = 0;

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


- (void) dealloc {
    NSLog(@"Bye");
    [self Dispose];
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