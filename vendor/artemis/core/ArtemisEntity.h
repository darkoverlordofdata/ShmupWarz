/**
 http://code.google.com/p/artemis-framework/source/browse/src/com/artemis/Entity.java
 */
#import <XCore.h>

#import "../util/ArtemisBitSet.h"
#import "ArtemisComponent.h"
#import "ArtemisComponentType.h"
#import "../util/ArtemisBag.h"

@class ArtemisWorld;

typedef NSUInteger EntityID; // ObjC to be clear - to support 64bit we need to make this NSUInteger. Calling it EntityID simply makes it easier to find this comment (and write clearer code!)

@interface ArtemisEntity : NSObject

/** ObjC: doesnt support protected, moved this to static */
+(ArtemisEntity*) entityInWorld:(ArtemisWorld*) world withId:(EntityID) newID;

/**
 * The internal id for this entity within the framework. No other entity
 * will have the same ID, but ID's are however reused so another entity may
 * acquire this ID if the previous entity was deleted.
 *
 * @return id of the entity.
 */
@property(nonatomic) EntityID Id; // note: not "id" which is reserved in objc

@property(nonatomic,retain,readonly) ArtemisBitSet* componentBits, * systemBits;

-(ArtemisEntity*) addComponent:( ArtemisComponent*) component;
-(ArtemisEntity*) addComponent:( ArtemisComponent*) component NSType:(ArtemisComponentType*) componentType;
-(ArtemisEntity*) removeComponent:(ArtemisComponent*) component;
/** ObjC: must rename */
-(ArtemisEntity*) removeComponentNSType:(ArtemisComponentType*) component;
-(void) reset;


/** FIXME: missing: the templated version of removeComponentNSType */

@property(nonatomic) bool isActive, isEnabled;

/** ObjC: slight rename */
-(ArtemisComponent*) componentNSType:(ArtemisComponentType*) componentType;

/** FIXME: missing: the templated version of componentNSType: */

-(ArtemisBag*) getComponentsIntoBag:(ArtemisBag*) fillBag;

-(void) addToWorld;
-(void) changedInWorld;
-(void) deleteFromWorld;

-(void) enable;
-(void) disable;

/**
 * Get the UUID for this entity.
 * This UUID is unique per entity (re-used entities get a new UUID).
 * @return uuid instance for this entity.
 */
@property(nonatomic,retain) NSString* uuid;

@property(nonatomic,readonly, assign /** NB: weak ref */) ArtemisWorld* world;

@end
