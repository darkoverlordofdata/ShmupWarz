#import <Foundation/Foundation.h>


@interface ArtemisBitSet : OFObject {
    int mLength;
    uint* mWords;
}
@property(nonatomic,readonly) bool isEmpty;
@property(nonatomic,readonly) bool length;

- (instancetype)init;
- (instancetype)initWithCapacity:(int) nbits;
- (uint) word:(int) index;
- (void) clear;
- (void) clear:(int) bitIndex;
- (void) set:(int) bitIndex;
- (void) set:(int) bitIndex to:(bool)value;
- (bool) get:(int) bitIndex;
- (bool) intersects:(ArtemisBitSet*) set;
- (int) nextSetBit:(int) fromIndex;
- (uint) numberOfTrailingZeros:(uint)i;

@end

