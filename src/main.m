#import <Foundation/Foundation.h>
#import "Shmupwarz.h"
#import "Systems.h"
#define var __auto_type
#define let const var

int main(int argc, char *argv[]) 
{

    let game = [[Shmupwarz alloc]initWithTitle:@"Shmupwarz" Width:720 Height:480];
    [game SetSystem:[[Systems alloc]initWithGame:game]];
    [game Run];

    return 0;
}
