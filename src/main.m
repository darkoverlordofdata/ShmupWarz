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
        var b1 = [[ArtemisBag alloc]init];

        var x1 = [[Point2D alloc]initWithX:1 Y:2];
        [b1 add:x1];

        NSLog(@"capacity of bag = %lu", b1.capacity);
        NSLog(@"size of bag = %lu", b1.size);

        Point2D* p = [b1 get:(NSUInteger)0];
        NSLog(@"retrieved: [%f:%f]", p.X, p.Y);

        let game = [[Shmupwarz alloc]initWithWidth:SCREEN_WIDTH Height:SCREEN_HEIGHT];
        [game Run];

   }
   return 0;
}
#endif