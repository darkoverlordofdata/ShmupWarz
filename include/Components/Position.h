/**
 
 */
#import <Foundation/Foundation.h>
#import <Artemis/Artemis.h>

// #import <Artemis/ArtemisComponent.h>

@interface Position : ArtemisComponent

+(Position*) positionWithX:(float) x y:(float) y;

@property(nonatomic) float x,y;

@end
