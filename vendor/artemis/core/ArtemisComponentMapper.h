/**
 http://code.google.com/p/artemis-framework/source/browse/src/com/artemis/ComponentMapper.java
 */
#import <XCore.h>

@class ArtemisWorld, ArtemisComponentType, ArtemisEntity;

@interface ArtemisComponentMapper : NSObject

+(ArtemisComponentMapper*) componentMapperForType:(Class) componentClass inWorld:(ArtemisWorld*) world;

-(NSObject*) get:(ArtemisEntity*) entity;
-(NSObject*) getSafe:(ArtemisEntity*) entity;
-(bool) has:(ArtemisEntity*) entity;

#pragma mark - ObjectiveC syntactic sugar that's very powerful...

/**
 Implements "self[0]", "self[1]", ... etc
 
 You can only subscript with (int) entity-id's or ArtemisEntity instances
 */
- (id)objectAtIndexedSubscript: (NSUInteger)index;

/**
 Implements "self[ (ArtemisEntity*) a ]", ... etc
 
 You can only subscript with (int) entity-id's or ArtemisEntity instances
 */
- (id)objectForKeyedSubscript: (id)key;

@end
