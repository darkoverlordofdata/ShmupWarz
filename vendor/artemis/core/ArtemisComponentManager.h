/**
 http://code.google.com/p/artemis-framework/source/browse/src/com/artemis/ComponentManager.java
 */
#import <XCore.h>

#import "../util/ArtemisBag.h"
#import "../util/ArtemisBitSet.h"
#import "ArtemisEntity.h"
#import "ArtemisManager.h"

@interface ArtemisComponentManager : ArtemisManager

/** ObjC: for safety, use this instead of relying on default undefined constrcutors */
+(ArtemisComponentManager*) componentManager;

-(void) addComponent:(ArtemisComponent*) component NSType:(ArtemisComponentType*) componentType toEntity:(ArtemisEntity*) entity;
-(void) removeComponent:(ArtemisComponentType*) componentType fromEntity:(ArtemisEntity*) entity;

-(ArtemisBag*) getComponentsByType:(ArtemisComponentType*) componentType;
-(ArtemisComponent*) getComponentNSType:(ArtemisComponentType*) componentType fromEntity:(ArtemisEntity*) entity;
-(ArtemisBag*) getComponentsFor:(ArtemisEntity*) entity intoBag:(ArtemisBag*) fillBag;

-(void) clean;

@end
