#import "Components.h"
@implementation Component
@end


@implementation Sound 
@synthesize Chunk = mChunk;
- (instancetype)initWithPath:(const char*)path {
    if (self = [super init]) {
        mChunk = Mix_LoadWAV(path);
    }
    return self;
}
@end

@implementation Point2D 
@synthesize X = mX;
@synthesize Y = mY;
- (instancetype)initWithX:(double)x Y:(double)y {
    if (self = [super init]) {
        mX = x;
        mY = y;
    }
    return self;
}
@end

@implementation Vector2D 
@synthesize X = mX;
@synthesize Y = mY;
- (instancetype)initWithX:(double)x Y:(double)y {
    if (self = [super init]) {
        mX = x;
        mY = y;
    }
    return self;
}
@end

@implementation Timer 
@synthesize Ms = mMs;
- (instancetype)initWithMs:(double)ms {
    if (self = [super init]) {
        mMs = ms;
    }
    return self;
}
@end

@implementation Scale 
@synthesize X = mX;
@synthesize Y = mY;
- (instancetype)initWithX:(double)x Y:(double)y {
    if (self = [super init]) {
        mX = x;
        mY = y;
    }
    return self;
}
@end

@implementation Color 
@synthesize R = mR;
@synthesize G = mG;
@synthesize B = mB;
@synthesize A = mA;
- (instancetype)initWithR:(int)r G:(int)g B:(int)b A:(int)a {
    if (self = [super init]) {
        mR = r;
        mG = g;
        mB = b;
        mA = a;
    }
    return self;
}
@end

@implementation Health 
@synthesize Current = mCurrent;
@synthesize Maximum = mMaximum;
- (instancetype)initWithCurrent:(double)current Maximum:(double)maximum {
    if (self = [super init]) {
        mCurrent = current;
        mMaximum = maximum;
    }
    return self;
}
@end

@implementation Tween 
@synthesize Min = mMin;
@synthesize Max = mMax;
@synthesize Speed = mSpeed;
@synthesize Repeat = mRepeat;
@synthesize Active = mActive;
- (instancetype)initWithMin:(double)min Max:(double)max Speed:(double)speed Repeat:(bool)repeat Active:(bool)active {
    if (self = [super init]) {
        mMin = min;
        mMax = max;
        mSpeed = speed;
        mRepeat = repeat;
        mActive = active;
    }
    return self;
}
@end

@implementation Transform 
@synthesize Texture = mTexture;
@synthesize Bounds = mBounds;
@synthesize Pos = mPos;
@synthesize Scale = mScale;
- (instancetype)initWithTexture:(Texture2D*)texture {
    return [self initWithTexture:texture Scale:1.0];
}
- (instancetype)initWithTexture:(Texture2D*)texture Scale:(double)scale {
    if (self = [super init]) {
        mTexture = texture;
        mBounds = (SDL_Rect){ 0, 0, (int)texture.Width, (int)texture.Height};
        mPos = [[Vector2D alloc]initWithX:0 Y:0];
        mScale = [[Vector2D alloc]initWithX:scale Y:scale];
    }
    return self;
}
- (SDL_Rect*)RefBounds { return &mBounds; }
- (void)X:(int)x Y:(int)y W:(int)w H:(int)h {
    mBounds.x = x;
    mBounds.y = y;
    mBounds.w = w;
    mBounds.h = h;
}
@end

@implementation Identity 
@synthesize Type = mType;
@synthesize Category = mCategory;
- (instancetype)initWithType:(TypeOf)type Category:(CategoryOf)category {
    if (self = [super init]) {
        mType = type;
        mCategory = category;
    }
    return self;
}
@end

@implementation Entity 
@synthesize Id = mId;
@synthesize Name = mName;
@synthesize Active = mActive;
@synthesize Transform = mTransform;
@synthesize Identity = mIdentity;
@synthesize Sound = mSound;
@synthesize Tint = mTint;
@synthesize Expires = mExpires;
@synthesize Health = mHealth;
@synthesize Tween = mTween;
@synthesize Velocity = mVelocity;
- (instancetype)initWithId:(int)id Name:(OFString*)name Active:(bool)active {
    if (self = [super init]) {
        mId = id;
        mName = name;
        mActive = active;
        mTransform = NULL;
        mIdentity = NULL;
        mSound = NULL;
        mTint = NULL;
        mExpires = NULL;
        mHealth = NULL;
        mTween = NULL;
        mVelocity = NULL;
    }
    return self;
}
@end