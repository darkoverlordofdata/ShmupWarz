/**
 * standalone version culled from 
 * https://github.com/gnustep/libs-corebase/blob/master/Source/CFBitVector.c
 */
# include "CFBitVector.h"

#if defined(__GNUC__) || defined(__llvm__)
#define POPCOUNT(u8) __builtin_popcount(u8)
#else
static UInt8 mu0 = 0x55;
static UInt8 mu1 = 0x33;
static UInt8 mu2 = 0x0F;
static inline CFIndex POPCOUNT(UInt8 u8)
{
  UInt8 x = u8 - ((u8>>1)&mu0);
  x = (x & mu1) + ((x>>2)&mu1);
  x = (x + (x>>4)) & mu2;
  return x & 0xFF;
}
#endif

CFRange CFRangeMake (CFIndex location, CFIndex length)
{
    CFRange range;

    range.location = location;
    range.length = length;
    return range;
}

struct __CFBitVector
{
    CFIndex       _count;
    CFIndex       _byteCount;
    UInt8        *_bytes;
};

#define CFBITVECTOR_SIZE sizeof(struct __CFBitVector)

void CFRelease(void* obj)
{
    free(obj);
}

static UInt8 SetOne (UInt8 byte, UInt8 mask, void *context) 
{
    return byte | mask;
}

static UInt8 SetZero (UInt8 byte, UInt8 mask, void *context)
{
    return byte & (~mask);
}

static UInt8 CountOne (UInt8 byte, UInt8 mask, void *context)
{
    CFIndex *count = (CFIndex*)context;
    
    *count += POPCOUNT(byte & mask);
    return byte;
}

static UInt8 CountZero (UInt8 byte, UInt8 mask, void *context)
{
    CFIndex *count = (CFIndex*)context;
    
    *count += POPCOUNT(~byte & mask);
    return byte;
}

static inline CFIndex CFBitVectorGetByte (CFIndex idx)
{
    return idx >> 3; /* idx / 8 */
}

static inline CFIndex CFBitVectorGetBitIndex (CFIndex idx)
{
    return idx & 7; /* idx % 8 */
}

static inline UInt8 CFBitVectorBitMask (UInt8 mostSig, UInt8 leastSig)
{
    return ((0xFF << (7 - leastSig + mostSig)) >> mostSig);
}

static void CFBitVectorOperation (CFBitVectorRef bv, CFRange range,
  UInt8 (*func)(UInt8, UInt8, void*), void *context)
{
    CFIndex curByte;
    CFIndex endByte;
    CFIndex startBit;
    CFIndex endBit;
    UInt8 mask;
    bool multiByte;
  
    curByte = CFBitVectorGetByte (range.location);
    endByte = CFBitVectorGetByte (range.location + range.length - 1);
    startBit = CFBitVectorGetBitIndex (range.location);
    endBit = CFBitVectorGetBitIndex (range.location + range.length - 1);
    
    /* First byte */
    if (curByte == endByte) {
        mask = CFBitVectorBitMask (startBit, startBit + endBit);
        multiByte = false;
    }
    else {
        mask = CFBitVectorBitMask (startBit, 7);
        multiByte = true;
    }
    bv->_bytes[curByte] = func (bv->_bytes[curByte], mask, context);
  
    /* Middle bytes */
    while (curByte < endByte) {
        bv->_bytes[curByte] = func (bv->_bytes[curByte], 0xFF, context);
        ++curByte;
    }
  
      /* Last byte */
    if (multiByte) {
        mask = CFBitVectorBitMask (0, endBit);
        bv->_bytes[curByte] = func (bv->_bytes[curByte], mask, context);
    }
}

CFIndex CFBitVectorGetByteCount (CFIndex numBits)
{
    return (numBits + 7) >> 3; /* (numBits + 7) / 8 */
}

CFBitVectorRef CFBitVectorCreate (void* alloc, const UInt8 *bytes,
  CFIndex numBits)
{
    struct __CFBitVector *new;
    CFIndex byteCount;
  
    byteCount = CFBitVectorGetByteCount (numBits);
    new = (struct __CFBitVector*)calloc(CFBITVECTOR_SIZE + byteCount, 0);
    if (new) {
        new->_count = numBits;
        new->_byteCount = byteCount;
        new->_bytes = (UInt8*)&new[1];
        
        memcpy (new->_bytes, bytes, byteCount);
    }
    
    return new;
}

CFMutableBitVectorRef CFBitVectorCreateMutable(void* alloc, CFIndex capacity)
{
    CFMutableBitVectorRef new;
  
    new = (CFMutableBitVectorRef)CFBitVectorCreate (alloc, NULL, 0);
    if (new) {
        CFIndex byteCount;
      
        // CFBitVectorSetMutable (new);
      
        byteCount = CFBitVectorGetByteCount(capacity);
        new->_bytes = calloc(byteCount, 0);
    }
  
    return new;
}
CFIndex CFBitVectorGetCount(CFBitVectorRef bv)
{
    return bv->_count;
}

CFBit CFBitVectorGetBitAtIndex(CFBitVectorRef bv, CFIndex idx)
{
    CFIndex byteIdx = CFBitVectorGetByte (idx);
    CFIndex bitIdx = CFBitVectorGetBitIndex (idx);
    return (bv->_bytes[byteIdx] >> (7 - bitIdx)) & 0x01;
}

CFIndex CFBitVectorGetCountOfBit (CFBitVectorRef bv, CFRange range, CFBit value)
{
    CFIndex count;
    CFBitVectorOperation (bv, range, value ? CountOne : CountZero, &count);
    return count;
}

bool CFBitVectorContainsBit(CFBitVectorRef bv, CFRange range, CFBit value)
{
    return (CFBitVectorGetCountOfBit (bv, range, value) > 0) ? true : false;
}

CFIndex CFBitVectorGetFirstIndexOfBit(CFBitVectorRef bv, CFRange range, CFBit value)
{
    CFIndex idx;
    
    for (idx = range.location ; idx < range.length ; idx++) {
        if (value == CFBitVectorGetBitAtIndex (bv, idx))
            return idx;
    }
  
    return kCFNotFound;    
}


void CFBitVectorSetAllBits( CFMutableBitVectorRef bv, CFBit value)
{
    UInt8 bytes = value ? 0xFF : 0x00;
    memset (bv->_bytes, bytes, bv->_byteCount);
}

void CFBitVectorSetBitAtIndex(CFMutableBitVectorRef bv, CFIndex idx, CFBit value)
{
    CFBitVectorOperation (bv, CFRangeMake(idx, 1), value ? SetOne : SetZero, NULL);
}

void CFBitVectorSetCount(CFMutableBitVectorRef bv, CFIndex count)
{
    if (count != bv->_count) {
        CFIndex newByteCount = CFBitVectorGetByteCount (count);
        
        if (newByteCount > bv->_byteCount) {
            UInt8 *newBytes;
            
            newBytes = calloc(newByteCount, 0);
            memcpy (newBytes, bv->_bytes, bv->_byteCount);
            
            free(bv->_bytes);
            
            bv->_bytes = newBytes;
            bv->_count = count;
        } 
        else {
            bv->_count = count;
        }
    }
}


