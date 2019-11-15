#import <Foundation/Foundation.h>
#import "Shmupwarz.h"
#import "Systems.h"
#import "Components.h"

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
    // var world = [ArtemisWorld new];
    // var as = [ArtemisAspect aspectForAll:@[[Timer class], [Scale class]]];

    // var bs = [ArtemisBitSet new];
    // [bs set:1 to:true];
    // [bs set:3 to:true];
    // [bs set:5 to:true];
    // [bs set:7 to:true];
    // [bs set:31 to:true];
    // OFLog(@"Bits: %@", bs);
    // for (int i=0; i<32; i++)
    //     OFLog(@"Next:%d :%d", i, [bs NextSetBit: i]);

    let game = [[Shmupwarz alloc]initWithWidth:SCREEN_WIDTH Height:SCREEN_HEIGHT];
    [game SetSystem:[[Systems alloc]initWithGame:game]];
    [game Run];

#ifndef RELEASE
    return 0;
#endif
}

#ifdef RELEASE
@end
#endif