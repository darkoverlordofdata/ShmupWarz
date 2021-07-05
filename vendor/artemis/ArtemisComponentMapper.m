#import "ArtemisComponentMapper.h"

#import "ArtemisBag.h"
#import "ArtemisEntity.h"
#import "ArtemisComponentType.h"
#import "ArtemisWorld.h"

@interface ArtemisComponentMapper()
@property(nonatomic,retain) ArtemisComponentType* type;
@property(nonatomic,retain) Class classType;
@property(nonatomic,retain) ArtemisBag* components;

@end
@implementation ArtemisComponentMapper


+(ArtemisComponentMapper*) componentMapperForType:(Class) componentClass inWorld:(ArtemisWorld*) world
{
	ArtemisComponentMapper* cm = [ArtemisComponentMapper new];
	
	cm.type = [ArtemisComponentType getTypeFor:componentClass];
	cm.components = [world.componentManager getComponentsByType:cm.type];
	cm.classType = componentClass;
	
	return cm;
}

-(OFObject*) get:(ArtemisEntity*) entity
{
	return [self.components get: entity.Id];
}

-(OFObject*) getSafe:(ArtemisEntity*) entity
{
	if( [self.components isIndexWithinBounds: entity.Id] )
	{
		return [self.components get:entity.Id];
	}
	
	return nil;
}

-(bool) has:(ArtemisEntity*) entity
{
	return [self getSafe:entity] != nil;
}

#pragma mark - ObjectiveC syntactic sugar that's very powerful...

- (id)objectAtIndexedSubscript: (OFUInteger)index
{
	return [self.components get:index];
}

- (id)objectForKeyedSubscript: (id)key
{
	// OFAssert([key isKindOfClass:[ArtemisEntity class]], @"You can only subscript with (int) entity-id's or ArtemisEntity instances");
	
	// if( [key isKindOfClass:[ArtemisEntity class]])
	// 	return [self get:(ArtemisEntity*) key];
	// else
	// 	return nil;
	return nil;

}

@end
