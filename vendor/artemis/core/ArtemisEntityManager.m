#import "ArtemisEntityManager.h"

@interface ArtemisIdentifierPool : OFObject
@property(nonatomic,retain) ArtemisBag* ids;
@property(nonatomic) OFUInteger nextAvailableId;

@end

@implementation ArtemisIdentifierPool

- (id)init
{
    self = [super init];
    if (self) {
        self.ids = [ArtemisBag bag];
    }
    return self;
}

-(EntityID) checkOut
{
	if( self.ids.size > 0 )
	{
		return [(OFNumber*)[self.ids removeLast] unsignedIntValue];
	}
	else
	{
		return self.nextAvailableId++;
	}
}

-(void) checkIn:(EntityID) newId
{
	[self.ids add:@(newId)];
}

@end


@interface ArtemisEntityManager()
@property(nonatomic,retain) ArtemisBag* entities;
@property(nonatomic,retain) ArtemisBitSet* disabled;

@property(nonatomic,readwrite) int activeEntityCount;
@property(nonatomic,readwrite) uint64_t totalCreated, totalAdded, totalDeleted;

@property(nonatomic,retain) ArtemisIdentifierPool* identifierPool;
@end

@implementation ArtemisEntityManager

+(ArtemisEntityManager *)entityManager
{
	ArtemisEntityManager* newValue = [ArtemisEntityManager new];
	
	return newValue;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.entities = [ArtemisBag bag];
		self.disabled = [ArtemisBitSet new];
		self.identifierPool = [ArtemisIdentifierPool new];
    }
    return self;
}

-(ArtemisEntity*) createEntityInstance
{
	ArtemisEntity* e = [ArtemisEntity entityInWorld:self.world withId:[self.identifierPool checkOut]];
	self.totalCreated++;
	return e;
}

-(void)added:(ArtemisEntity *)entity
{
	self.activeEntityCount++;
	self.totalAdded++;
	[self.entities setItem:entity atIndex:entity.Id];
}

-(void)enabled:(ArtemisEntity *)entity
{
	[self.disabled clear:(OFInteger)entity.Id];
}

-(void)disabled:(ArtemisEntity *)entity
{
	[self.disabled set:(OFInteger)entity.Id];
}

-(void)deleted:(ArtemisEntity *)entity
{
	[self.entities setItem:[OFNull null] atIndex:entity.Id];
	// [self.entities setItem:nil atIndex:entity.Id];
	
	[self.disabled clear:(OFInteger)entity.Id];
	
	[self.identifierPool checkIn:entity.Id];
	
	self.activeEntityCount--;
	self.totalDeleted++;
}

-(bool) isActive:(EntityID) entityID
{
	return [self.entities get:entityID] != [OFNull null];
	// return [self.entities get:entityID] != nil;
}

-(bool) isEnabled:(EntityID) entityID
{
	return ! [self.disabled get:(OFInteger)entityID];
}

-(ArtemisEntity*) getEntity:(EntityID) entityId
{
	return (ArtemisEntity*) [self.entities get:entityId];
}

@end
