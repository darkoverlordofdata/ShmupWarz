#import "ArtemisComponentType.h"

@interface ArtemisComponentType()
@property(nonatomic) Class Type;
@property(nonatomic,readwrite) OFUInteger index;
@end

@implementation ArtemisComponentType

static int INDEX;
static OFMutableDictionary* componentTypes;

- (id)initWithType:(Class) type
{
	if( componentTypes == nil )
	{
		INDEX = 0;
		componentTypes = [OFMutableDictionary dictionary];
	}
	
    self = [super init];
    if (self) {
        self.index = INDEX++;
		self.Type = type;
    }
    return self;
}

- (OFString *)description
{
	return [OFString stringWithFormat:@"ComponentType[%@] (%lu)", self.Type, (unsigned long)self.index];
}

+ (ArtemisComponentType*) getTypeFor:(Class) c
{
	ArtemisComponentType* type = [componentTypes objectForKey:c];
	
	if (type == nil)
	{
		type = [[ArtemisComponentType alloc] initWithType:c];
		[componentTypes setObject:type forKey:(id<OFCopying>)c]; // ObjC: looks wrong but IS OFFICIALLY legal and correct (ask Apple!)
	}
	
	return type;
}

+ (OFUInteger) getIndexFor:(Class) c
{
	return ((ArtemisComponentType*)[self getTypeFor:c]).index;
}

@end
