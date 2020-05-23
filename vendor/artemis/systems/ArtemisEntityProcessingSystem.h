/**
 http://code.google.com/p/artemis-framework/source/browse/src/com/artemis/systems/EntityProcessingSystem.java
 */
#import <XCore.h>

#import "../core/ArtemisAspect.h"
#import "../core/ArtemisEntitySystem.h"

@interface ArtemisEntityProcessingSystem : ArtemisEntitySystem

+(ArtemisEntityProcessingSystem*) entityProcessingSystemWithAspect:(ArtemisAspect*) aspect;

/** ObjC subclasses need to see this */
- (id)initWithAspect:(ArtemisAspect*) aspect;

-(void) process:(ArtemisEntity*) entity;

@end
