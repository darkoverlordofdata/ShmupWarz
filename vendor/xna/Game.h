#import <Foundation/Foundation.h>
#import <SDL2/SDL.h>
#import <SDL2/SDL_image.h>
#import <time.h>
#import <sys/time.h>
#import "OpenGL.h"

#define TicksPerMillisecond  10000.0
#define MillisecondsPerTick 1.0 / (TicksPerMillisecond)

#define TicksPerSecond TicksPerMillisecond * 1000.0   // 10,000,000
#define SecondsPerTick  1.0 / (TicksPerSecond)         // 0.0001

#define SCAN_MASK 0x1ff

@interface Game : NSObject  
{
    bool mKeys[SCAN_MASK]; // flag per scan code
    bool mIsRunning;
    bool mMouseDown;
    float mMouseX;
    float mMouseY;
    SDL_Window* mWindow;
    NSString* mTitle;
    GLuint mWidth;
    GLuint mHeight;
    double mDelta;

    int mTicks;
    int mFps;
    bool mIsFixedTimeStep;
    bool mIsRunningSlowly;
    uint64_t mTargetElapsedTime;
    uint64_t mAccumulatedElapsedTime;
    uint64_t mMaxElapsedTime;
    uint64_t mTotalGameTime;
    uint64_t mElapsedGameTime;
    uint64_t mCurrentTime;
    long mPreviousTicks;
    int mUpdateFrameLag;
    bool mShouldExit;
    bool mSuppressDraw;
}

@property (nonatomic, assign) double Delta;
@property (nonatomic, assign) bool IsRunning;
@property (nonatomic, assign) bool MouseDown;
@property (nonatomic, assign) float MouseX;
@property (nonatomic, assign) float MouseY;
@property (nonatomic, assign) GLuint Width;
@property (nonatomic, assign) GLuint Height;
@property (nonatomic, assign) SDL_Window* Window;
@property (nonatomic, retain) NSString* Title;

- (instancetype)initWithTitle:(NSString*)title
                        Width:(int)width 
                        Height:(int)height;
- (NSString*)ToString;
- (void)Start;
- (void)Stop;
- (void)Quit;
- (void)Run;
- (void)Initialize;
- (void)LoadContent;
- (void)RunLoop;
- (void)Update:(GLfloat) delta;
- (void)Draw:(GLfloat) delta;
- (void)HandleEvents;
- (void)Tick;
- (void)Dispose;
- (void)CreatePlatform;
- (bool)GetKey:(int) Key;

@end
