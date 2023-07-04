#import <Foundation/Foundation.h>
#import "Shmupwarz.h"
#import "Systems.h"
#define var __auto_type
#define let const var

int main(int argc, char *argv[]) 
{

    @autoreleasepool {
        let game = [[Shmupwarz alloc]initWithTitle:@"Shmupwarz" Width:1080 Height:640];
        [game SetSystem:[[Systems alloc]initWithGame:game]];
        [game Run];
    }
    return 0;
}
