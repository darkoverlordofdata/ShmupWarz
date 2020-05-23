#import "ArtemisBag.h"

@interface ArtemisBag()

/** FIXME: not implemented as high performance yet */
@property(nonatomic,retain) NSMutableArray* data;
@property(nonatomic) NSUInteger filledItems;
@end

@implementation ArtemisBag

+(ArtemisBag*) bag
{
	ArtemisBag* newValue = [[ArtemisBag alloc] initWithCapacity:64];
	
	return newValue;
}

/** Objc: prevent people from bypassing the contructor */
- (id)init
{
    // return [self initWithCapacity:10];
    return [self initWithCapacity:64];
}

-(id)initWithCapacity:(NSInteger) c
{
    self = [super init];
    if (self) {
        self.data = [NSMutableArray arrayWithCapacity:c];
		self.filledItems = 0;
		for( int i=0; i<c; i++ ) // ObjC: Note Apple's nasty nsarray capacity isn't readable
		{
			[self.data addObject:[NSNull null]];
		}
    }
    return self;
}

-(NSObject*) remove:(NSUInteger) index
{
	NSObject* item = [self.data objectAtIndex:index];
	
	/** FIXME: not implemented as high performance yet */
	
	return item;
}

-(NSObject*) removeLast
{
	if( self.size > 0 )
	{
		
		/** FIXME: not implemented as high performance yet */
	
		return [self remove:self.filledItems-1];
	}
	
	return nil;
}

/** Have to rename method, Objc doesn't support overloading, it's too basic/weak a language */
-(bool) removeFirst:(id) item
{
	
	/** FIXME: not implemented as high performance yet */
	
	for( NSUInteger i = 0; i < self.size; i++ )
	{
		id itemOriginal = [self.data objectAtIndex:i];
		
		if( itemOriginal == item )
		{
			[self.data replaceObjectAtIndex:i withObject:[self.data objectAtIndex:self.size-1]];
			[self.data replaceObjectAtIndex:self.size-1 withObject:[NSNull null]];
			self.filledItems--;
			
			return true;
		}
	}
	
	return false;
}


-(bool) contains:(id) item
{
	
	/** FIXME: not implemented as high performance yet */
	
	return [self.data containsObject:item];
}

-(bool) removeAll:(ArtemisBag*) otherBag
{
	bool modified = false;
	
	
	/** FIXME: not implemented as high performance yet */
	
	NSUInteger oldSize = self.size;
	for (id obj in otherBag.data) {
		[self.data removeObject:obj];
	}
	modified = (oldSize != self.size);
	
	return modified;
}

-(NSObject*) get:(NSUInteger) index
{
	NSObject* value = [self.data objectAtIndex:index];
	return ( value == [NSNull null]) ? nil : value; /** ObjC: have to convert NSNull to nil */
}

-(NSUInteger)size
{
	return self.filledItems;
}

-(NSUInteger)capacity
{
	return self.data.count;
}

-(bool) isIndexWithinBounds:(NSUInteger) bounds
{
	return bounds < self.capacity;
}

-(bool)isEmpty
{
	return self.size == 0;
}

-(void) add:(NSObject*) item
{
	if( self.size == self.capacity )
	{
		[self grow];
	}
	
	[self.data replaceObjectAtIndex:self.filledItems withObject:item];
	self.filledItems++;
}

/** Have to rename for objc */
-(void) setItem:(NSObject*) item atIndex:(NSUInteger) index
{
	if( index > self.capacity)
	{
		[self growTo: index * 2];
	}
	
	[self.data replaceObjectAtIndex:index withObject:item];
	self.filledItems++;
}

-(void) ensureCapacity:(NSUInteger) index
{
	if( index > self.capacity )
		[self growTo: index * 2];
}

-(void) clear
{
	[self.data removeAllObjects];
	self.filledItems = 0;
}

-(void) addAll:(ArtemisBag*) otherBag
{
	for( NSObject* item in otherBag.data )
	{
		if( item != nil && item != [NSNull null] )
		{
			[self add:item];
		}
	}
}

#pragma mark private methods

-(void) grow
{
	NSUInteger newCapacity = ( self.capacity * 3 ) / 2 + 1;
	[self growTo: newCapacity];
}

/** Must rename, Objc too crappy to allow poly */
-(void) growTo:(NSUInteger) newCapacity
{
	NSUInteger currentCapacity = self.capacity;
	
	for( NSUInteger i=currentCapacity; i<newCapacity; i++ )
	{
		[self.data addObject:[NSNull null]]; // but do NOT change the filledItems count
	}
}

@end
