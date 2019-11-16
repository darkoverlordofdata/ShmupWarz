#import "ArtemisWorld.h"

#import "ArtemisBag.h"
#import "ArtemisImmutableBag.h"
#import "ArtemisEntitySystem.h"
#import "ArtemisEntityObserver.h"

// #import "ArtemisWorld_Debug.h"
@interface ArtemisWorld ()

@property(nonatomic) bool objcDebugEachTick;
@property(nonatomic) uint64_t objDebugNumTicksSinceStarted;

@end


typedef void (^Performer)(OFObject<ArtemisEntityObserver>* observer, ArtemisEntity* entity);

@interface ArtemisComponentMapperInitHelper : OFObject
+(void) configTarget:(OFObject*) target inWorld:(ArtemisWorld*) world;
@end
@implementation ArtemisComponentMapperInitHelper
+(void)configTarget:(OFObject *)target inWorld:(ArtemisWorld *)world
{
	/** @see valagame for alternative: ArtemisTemplate */
	//OFLog(@"IMPOSSIBLE IN OBJECTIVE C: Annotations are a Java-language exclusive feature");
}
@end

@interface ArtemisWorld()
@property(nonatomic,retain) ArtemisBag* added, * changed, * deleted, * enable, * disable;

@property(nonatomic,retain) OFMutableDictionary* managers;
@property(nonatomic,retain) ArtemisBag* managersBag;

@property(nonatomic,retain) OFMutableDictionary* systems;
@property(nonatomic,retain) ArtemisBag* systemsBag;

#pragma mark - ObjectiveC customizations


@end

@implementation ArtemisWorld

-(id) init
{
    if (self = [super init])
    {
		self.managers = [OFMutableDictionary dictionary];
		self.managersBag = [ArtemisBag bag];
		
		self.systems = [OFMutableDictionary dictionary];
		self.systemsBag = [ArtemisBag bag];
		
		self.added = [ArtemisBag bag];
		self.changed = [ArtemisBag bag];
		self.deleted = [ArtemisBag bag];
		self.enable = [ArtemisBag bag];
		self.disable = [ArtemisBag bag];
		
		self.componentManager = [ArtemisComponentManager componentManager];
		[self setManager:self.componentManager];
		
		self.entityManager = [ArtemisEntityManager entityManager];
		[self setManager:self.entityManager];
		self.objcDebugEachTick = true;
    }
    return self;
}

-(void) initialize
{
	for( OFUInteger i=0; i < self.managersBag.size; i++ )
	{
		[(ArtemisManager*)[self.managersBag get:i] initialize];
	}
	
	for( OFUInteger i=0; i < self.systemsBag.size; i++ )
	{
		/** Inject the component mappers into each system */
		/** IMPOSSIBLE IN OBJECTIVE C: Annotations are a Java-language exclusive feature */
		/** @see valagame for alternative: ArtemisTemplate */
		[ArtemisComponentMapperInitHelper configTarget:[self.systemsBag get:i] inWorld:self];
		[(ArtemisEntitySystem*)[self.systemsBag get:i] initialize];
	}
}

-(ArtemisManager*) setManager:(ArtemisManager*) manager
{
	[self.managers setObject:manager forKey:(id)[manager class]];
	[self.managersBag add:manager];
	manager.world = self;
	return manager;
}

-(ArtemisManager *) getManager:(Class)managerClass
{
	return [self.managers objectForKey:managerClass];
}

-(void) deleteManager:(ArtemisEntityManager*) manager
{
	[self.managers removeObjectForKey:[manager class]];
	[self.managersBag removeFirst:manager];
}

-(void) addEntity:(ArtemisEntity*) entity
{
	[self.added add:entity];
}

-(void) changedEntity:(ArtemisEntity*) entity
{
	[self.changed add:entity];
}

-(void) deleteEntity:(ArtemisEntity*) entity
{
	if( ! [self.deleted contains:entity])
		[self.deleted add:entity];
}

-(void) enable:(ArtemisEntity*) entity
{
	[self.enable add:entity];
}

-(void) disable:(ArtemisEntity*) entity
{
	[self.disable add:entity];
}

-(ArtemisEntity*) createEntity
{
	return [self.entityManager createEntityInstance];
}

-(ArtemisEntity*) getEntity:(EntityID) entityId
{
	return [self.entityManager getEntity:entityId];
}

-(OFObject<ArtemisImmutableBag>*) getSystems
{
	return self.systemsBag;
}

-(ArtemisEntitySystem*) setSystem:(ArtemisEntitySystem*) system
{
	return [self setSystem:system passive:false];
}

-(ArtemisEntitySystem*) setSystem:(ArtemisEntitySystem*) system passive:(bool) passive
{
	system.world = self;
	system.isPassive = passive;
	
	[self.systems setObject:system forKey:(id<OFCopying>)[system class]]; // Looks wrong, but Apple OFFICIALLY approves
	[self.systemsBag add:system];
	
	return system;
}

-(void) deleteSystem:(ArtemisEntitySystem*) system
{
	[self.systems removeObjectForKey:[system class]];
	[self.systemsBag removeFirst:system];
}

-(void) notifySystems:(ArtemisEntity*) entity withBlock:(Performer) performer
{
	for( OFUInteger i=0, s = self.systemsBag.size; s > i; i++ )
	{
		performer( (OFObject<ArtemisEntityObserver>*)[self.systemsBag get:i], entity );
	}
}

-(void) notifyManagers:(ArtemisEntity*) entity withBlock:(Performer) performer
{
	for( OFUInteger i=0, s = self.managersBag.size; s > i; i++ )
	{
		performer( (OFObject<ArtemisEntityObserver>*)[self.managersBag get:i], entity );
	}
}

-(ArtemisEntitySystem*) getSystem:(Class) c
{
	return [self.systems objectForKey:c];
}

-(void) check:(ArtemisBag*) entities withBlock:(Performer) performer
{
	if( ! entities.isEmpty )
	{
		for( OFUInteger i = 0; entities.size > i; i++ )
		{
			ArtemisEntity* entity = (ArtemisEntity*)[entities get:i];
			[self notifyManagers:entity withBlock:performer];
			[self notifySystems:entity withBlock:performer];
		}
		[entities clear];
	}
}

-(void) process
{
	self.objDebugNumTicksSinceStarted++;
	
	[self check:self.added withBlock:^(OFObject<ArtemisEntityObserver> *observer, ArtemisEntity *entity) {
		[observer added:entity];
	}];
	
	[self check:self.changed withBlock:^(OFObject<ArtemisEntityObserver> *observer, ArtemisEntity *entity) {
		[observer changed:entity];
	}];
	
	[self check:self.disable withBlock:^(OFObject<ArtemisEntityObserver> *observer, ArtemisEntity *entity) {
		[observer disabled:entity];
	}];
	
	[self check:self.enable withBlock:^(OFObject<ArtemisEntityObserver> *observer, ArtemisEntity *entity) {
		[observer enabled:entity];
	}];
	
	[self check:self.deleted withBlock:^(OFObject<ArtemisEntityObserver> *observer, ArtemisEntity *entity) {
		[observer deleted:entity];
	}];
	
	[self.componentManager clean];
	
	for( OFUInteger i = 0; self.systemsBag.size > i; i++ )
	{
		ArtemisEntitySystem* system = (ArtemisEntitySystem*) [self.systemsBag get:i];
		if( ! system.isPassive )
		{
			[system process];
		}
	}
}

#pragma mark - ObjectiveC customizations

@end
