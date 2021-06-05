#import <XCore.h>
#import "Shmupwarz.h"
#import "Components.h"

// The Width of the screen
const GLuint SCREEN_WIDTH = 720;
// The height of the screen
const GLuint SCREEN_HEIGHT = 480;
  
#ifdef OBJFW

// #define RELEASE 1
#ifdef RELEASE
@interface Application: NSObject <NSApplicationDelegate>
@end

NS_APPLICATION_DELEGATE(Application)

@implementation Application
- (void)applicationDidFinishLaunching
#else
int main(int argc, char *argv[]) 
#endif
{
    let game = [[Shmupwarz alloc]initWithWidth:SCREEN_WIDTH Height:SCREEN_HEIGHT];
    [game Run];

#ifndef RELEASE
    return 0;
#endif
}

#ifdef RELEASE
@end
#endif

#else
int main(int argc, const char **argv, char** env)
{
   @autoreleasepool 
   {
        let game = [[Shmupwarz alloc]initWithWidth:SCREEN_WIDTH Height:SCREEN_HEIGHT];
        [game Run];

   }
   return 0;
}
#endif