#import <Foundation/Foundation.h>


@interface ArtemisBitSet : OFObject {
    int mLength;
    uint* mWords;
}

+ (ArtemisBitSet*) BitSet;

@property(nonatomic,readonly) bool IsEmpty;
@property(nonatomic,readonly) bool Length;

- (instancetype)init;
- (instancetype)initWithCapacity:(int) nbits;
- (uint) Word:(int) index;
- (void) Clear;
- (void) Clear:(int) bitIndex;
- (void) Set:(int) bitIndex To:(bool)value;
- (bool) Get:(int) bitIndex;
/** "Returns true if the specified BitSet has any bits set to true that are also set to true in this BitSet." */
- (bool) Intersects:(ArtemisBitSet*) set;
/** "Returns the index of the first bit that is set to true that occurs on or after the specified starting index." */
- (int) NextSetBit:(int) fromIndex;

- (uint) numberOfTrailingZeros:(uint)i;

@end

