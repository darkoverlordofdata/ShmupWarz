/**
 
 */
#import "../../Classes/systems/ArtemisEntityProcessingSystem.h"

#import "../Components/Position.h"
#import "../Components/Velocity.h"

@interface MovementSystem : ArtemisEntityProcessingSystem

+(MovementSystem*) movementSystem;

@end
