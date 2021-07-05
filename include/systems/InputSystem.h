/**
 
 */
// #import "ArtemisEntityProcessingSystem.h"
#import <artemis/artemis.h>

#import "../Shmupwarz.h"
#import "../Components.h"

@interface InputSystem : ArtemisEntityProcessingSystem {
double mTimeToFire;

}

+(InputSystem*) inputSystem;

@end
