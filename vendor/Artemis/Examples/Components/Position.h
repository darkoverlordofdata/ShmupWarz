/**
 
 */
#import <Foundation/Foundation.h>

#import "../../Classes/ArtemisComponent.h"

@interface Position : ArtemisComponent

+(Position*) positionWithX:(float) x y:(float) y;

@property(nonatomic) float x,y;

@end
