/**
 
 */
#import <Foundation/Foundation.h>
#import <Artemis/Artemis.h>
// #import <Artemis/systems/ArtemisEntityProcessingSystem.h>

#import "../Components/Position.h"
#import "../Components/Velocity.h"

@interface MovementSystem : ArtemisEntityProcessingSystem

+(MovementSystem*) movementSystem;

@end
