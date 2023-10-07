/**
 
 */
#import <Foundation/Foundation.h>
#import <Artemis/Artemis.h>
// #import <Artemis/ArtemisComponent.h>

@interface Velocity : ArtemisComponent

+(Velocity*) velocityWithDeltaX:(float) x deltaY:(float) y;

@property(nonatomic) float dx, dy;

@end
