#import "ArtemisEntity.h"
#import "ArtemisEntityManager.h"
#import "ArtemisComponentManager.h"

#import "ArtemisWorld.h"

@interface ArtemisEntity()
@property(nonatomic,retain,readwrite) ArtemisBitSet* componentBits, * systemBits;
@property(nonatomic,retain) ArtemisEntityManager* entityManager;
@property(nonatomic,retain) ArtemisComponentManager* componentManager;

@property(nonatomic,readwrite,assign /** NB: weak ref */) ArtemisWorld* world;
@end

@implementation ArtemisEntity

+(ArtemisEntity *)entityInWorld:(ArtemisWorld *)world withId:(EntityID)newID
{
	ArtemisEntity* newValue = [ArtemisEntity new];
	
    newValue.Id = newID;
	newValue.world = world;
	newValue.entityManager = world.entityManager;
	newValue.componentManager = world.componentManager;
	newValue.systemBits = [ArtemisBitSet new];
	newValue.componentBits = [ArtemisBitSet new];
	
	[newValue reset];
	
	return newValue;
}

-(void) reset
{
	[self.systemBits clear];
	[self.componentBits clear];
	self.uuid = [NSString new]; //UUID];
}

-(NSString *)description
{
	return [NSString stringWithFormat:@"Entity[%lu]", (unsigned long)self.Id];
}

-(ArtemisEntity*) addComponent:( ArtemisComponent*) component
{
	[self addComponent:component NSType:[ArtemisComponentType getTypeFor:[component class]]];
	
	return self;
}

-(ArtemisEntity*) addComponent:( ArtemisComponent*) component NSType:(ArtemisComponentType*) componentType
{
	[self.componentManager addComponent:component NSType:componentType toEntity:self];
	
	return self;
}

-(ArtemisEntity*) removeComponent:(ArtemisComponent*) component
{
	[self removeComponentNSClass:[component class]];

	return self;
}

/** ObjC: must rename */
-(ArtemisEntity*) removeComponentNSType:(ArtemisComponentType*) component
{
	[self.componentManager removeComponent:component fromEntity:self];
	
	return self;
}

/** ObjC: must rename */
-(ArtemisEntity*) removeComponentNSClass:(Class) componentClass
{
	[self.componentManager removeComponent:[ArtemisComponentType getTypeFor:componentClass] fromEntity:self];
	
	return self;
}


-(bool)isActive
{
	return [self.entityManager isActive:self.Id];
}

-(bool)isEnabled
{
	return [self.entityManager isEnabled:self.Id];
}

/** ObjC: slight rename */
-(ArtemisComponent*) componentNSType:(ArtemisComponentType*) componentType
{
	return [self.componentManager getComponentNSType:componentType fromEntity:self];
}

/** FIXME: missing: the templated version of componentNSType: */

-(ArtemisBag*) getComponentsIntoBag:(ArtemisBag*) fillBag
{
	return [self.componentManager getComponentsFor:self intoBag:fillBag];
}

-(void) addToWorld
{
	[self.world addEntity:self];
}

-(void) changedInWorld
{
	[self.world changedEntity:self];
}

-(void) deleteFromWorld
{
	[self.world deleteEntity:self];
}

-(void) enable
{
	[self.world enable:self];
}

-(void) disable
{
	[self.world disable:self];
}

@end
