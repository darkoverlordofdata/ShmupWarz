/**
 * standalone version culled from 
 * https://github.com/gnustep/libs-corebase/blob/master/Headers/CoreFoundation/CFBitVector.h
 */
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define kCFAllocatorDefault NULL

typedef unsigned char UInt8;
typedef uint32_t UInt32;
typedef UInt32 CFBit;
typedef const struct __CFBitVector* CFBitVectorRef;
typedef struct __CFBitVector* CFMutableBitVectorRef;
typedef long CFIndex;
typedef struct CFRange CFRange;

// const CFIndex kCFNotFound;
#define kCFNotFound -1

struct CFRange 
{
    CFIndex location;
    CFIndex length;
};

CFRange CFRangeMake(CFIndex loc, CFIndex len);

void CFRelease( void*);

CFIndex CFBitVectorGetByteCount (CFIndex numBits);

CFMutableBitVectorRef CFBitVectorCreateMutable(void* allocator, CFIndex capacity);
void CFBitVectorSetAllBits( CFMutableBitVectorRef bv, CFBit value);
void CFBitVectorSetCount(CFMutableBitVectorRef bv, CFIndex count);
void CFBitVectorSetBitAtIndex(CFMutableBitVectorRef bv, CFIndex idx, CFBit value);
void CFBitVectorSetBitAtIndex(CFMutableBitVectorRef bv, CFIndex idx, CFBit value);
CFIndex CFBitVectorGetCountOfBit (CFBitVectorRef bv, CFRange range, CFBit value);
CFIndex CFBitVectorGetCount(CFBitVectorRef bv);
CFBit CFBitVectorGetBitAtIndex(CFBitVectorRef bv, CFIndex idx);
bool CFBitVectorContainsBit(CFBitVectorRef bv, CFRange range, CFBit value);
CFIndex CFBitVectorGetFirstIndexOfBit(CFBitVectorRef bv, CFRange range, CFBit value);

