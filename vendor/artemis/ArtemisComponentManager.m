#import "ArtemisComponentManager.h"

@interface ArtemisComponentManager()
@property(nonatomic,retain) ArtemisBag* componentsByType, * deleted;

@end

@implementation ArtemisComponentManager

+(ArtemisComponentManager *)componentManager
{
	ArtemisComponentManager* newValue = [[ArtemisComponentManager new] autorelease];
	
	return newValue;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.componentsByType = [ArtemisBag bag];
		self.deleted = [ArtemisBag bag];
    }
    return self;
}

-(void) removeComponentsOfEntity:(ArtemisEntity*) entity
{
	ArtemisBitSet* componentBits = entity.componentBits;
	for( OFInteger i = [componentBits nextSetBit:0]; i >= 0; i = [componentBits nextSetBit:i+1])
	{
		[(ArtemisBag*)[self.componentsByType get:(OFUInteger)i] setItem:[OFNull null] atIndex:entity.Id];
	}
	[componentBits clear];
}

-(void) addComponent:(ArtemisComponent*) component ofType:(ArtemisComponentType*) componentType toEntity:(ArtemisEntity*) entity
{
	[self.componentsByType ensureCapacity: componentType.index];
	
	ArtemisBag* components = (ArtemisBag*)[self.componentsByType get: componentType.index];
	if( components == nil )
	{
		components = [ArtemisBag bag];
		[self.componentsByType setItem:components atIndex:componentType.index];
	}
	
	[components setItem:component atIndex:entity.Id];
	
	[entity.componentBits set: (OFInteger)componentType.index];
}

-(void) removeComponent:(ArtemisComponentType*) componentType fromEntity:(ArtemisEntity*) entity
{
	if( [entity.componentBits get:(OFInteger)componentType.index])
	{
		[(ArtemisBag*)[self.componentsByType get: componentType.index] setItem:[OFNull null] atIndex:entity.Id];
		[entity.componentBits clear: (OFInteger)componentType.index];
	}
}

-(ArtemisBag*) getComponentsByType:(ArtemisComponentType*) componentType
{
	ArtemisBag* components = (ArtemisBag*) [self.componentsByType get: componentType.index];
	if( components == nil )
	{
		components = [ArtemisBag bag];
		[self.componentsByType setItem:components atIndex:componentType.index];
	}
	return components;
}

-(ArtemisComponent*) getComponentOfType:(ArtemisComponentType*) componentType fromEntity:(ArtemisEntity*) entity
{
	ArtemisBag* components = (ArtemisBag*) [self.componentsByType get: componentType.index];
	if( components != nil )
	{
		return (ArtemisComponent*) [components get: entity.Id];
	}
	else
		return nil;
}

-(ArtemisBag*) getComponentsFor:(ArtemisEntity*) entity intoBag:(ArtemisBag*) fillBag
{
	ArtemisBitSet* componentBits = entity.componentBits;
	for( OFInteger i = [componentBits nextSetBit:0]; i >= 0; i = [componentBits nextSetBit:i+1])
	{
		[fillBag add: [((ArtemisBag*)[self.componentsByType get:(OFUInteger)i]) get:entity.Id]];
	}
	
	return fillBag;
}

-(void)deleted:(id)entity
{
	[self.deleted add:entity];
}

-(void) clean
{
	if( self.deleted.size > 0 )
	{
		for( OFUInteger i=0; self.deleted.size > i; i++ )
		{
			[self removeComponentsOfEntity:(ArtemisEntity*)[self.deleted get:i]];
		}
		[self.deleted clear];
	}
}

@end
