#import <Foundation/Foundation.h>


@interface ArtemisBitSet : OFObject {
    int mLength;
    uint* mWords;
}
@property(nonatomic,readonly) bool IsEmpty;
@property(nonatomic,readonly) bool Length;

- (instancetype)init;
- (instancetype)initWithCapacity:(int) nbits;
- (uint) Word:(int) index;
- (void) Clear;
- (void) Clear:(int) bitIndex;
- (void) Set:(int) bitIndex To:(bool)value;
- (bool) Get:(int) bitIndex;
- (bool) Intersects:(ArtemisBitSet*) set;
- (int) NextSetBit:(int) fromIndex;
- (uint) numberOfTrailingZeros:(uint)i;

@end

