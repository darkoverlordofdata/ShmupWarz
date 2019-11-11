#import <Foundation/Foundation.h>
#import <artemis/artemis.h>
#import "Shmupwarz.h"
#import "Systems.h"
// The Width of the screen
const GLuint SCREEN_WIDTH = 720;
// The height of the screen
const GLuint SCREEN_HEIGHT = 480;
  
// #define RELEASE 1
#ifdef RELEASE
@interface Application: OFObject <OFApplicationDelegate>
@end

OF_APPLICATION_DELEGATE(Application)

@implementation Application
- (void)applicationDidFinishLaunching
#else
int main(int argc, char *argv[]) 
#endif
{
    var bs = [ArtemisBitSet new];
    [bs Set:1 To:true];
    [bs Set:3 To:true];
    [bs Set:5 To:true];
    [bs Set:7 To:true];
    [bs Set:31 To:true];
    OFLog(@"Bits: %@", bs);
    for (int i=0; i<32; i++)
        OFLog(@"Next:%d :%d", i, [bs NextSetBit: i]);

    // let game = [[Shmupwarz alloc]initWithWidth:SCREEN_WIDTH Height:SCREEN_HEIGHT];
    // [game SetSystem:[[Systems alloc]initWithGame:game]];
    // [game Run];

#ifndef RELEASE
    return 0;
#endif
}

#ifdef RELEASE
@end
#endif