#import <Foundation/Foundation.h>
#import <xna/xna.h>
#import <artemis/artemis.h>


typedef enum TypeOf {
    TYPE_NONE,
    TYPE_BACKGROUND,
    TYPE_TEXT,
    TYPE_LIVES,
    TYPE_ENEMY1,
    TYPE_ENEMY2,
    TYPE_ENEMY3,
    TYPE_PLAYER,
    TYPE_BULLET,
    TYPE_EXPLOSION,
    TYPE_BANG,
    TYPE_PARTICLE,
    TYPE_HUD
} TypeOf;

typedef enum CategoryOf {
    CATEGORY_NONE,
    CATEGORY_BACKGROUND,
    CATEGORY_BULLET,
    CATEGORY_ENEMY,
    CATEGORY_EXPLOSION,
    CATEGORY_PARTICLE,
    CATEGORY_PLAYER
} CategoryOf;

@interface Player : ArtemisComponent 
{
}
@end

@interface Sound : ArtemisComponent 
{
    Mix_Chunk* mChunk;
    OFString* mPath;
}
@property (nonatomic, retain) OFString* Path;
@property (nonatomic, assign) Mix_Chunk* Chunk;
- (instancetype)initWithPath:(const char*)path;
@end

@interface Point2D : ArtemisComponent 
{
    double mX;
    double mY;
}
@property (nonatomic, assign) double X;
@property (nonatomic, assign) double Y;
- (instancetype)initWithX:(double)x Y:(double)y;
@end

@interface Vector2D : ArtemisComponent 
{
    double mX;
    double mY;
}
@property (nonatomic, assign) double X;
@property (nonatomic, assign) double Y;
- (instancetype)initWithX:(double)x Y:(double)y;
@end

@interface Velocity : Vector2D 
@end


@interface Timer : ArtemisComponent 
{
    double mMs;
    bool mDec;
}
@property (nonatomic, assign) double Ms;
- (instancetype)initWithMs:(double)ms;
- (instancetype)initWithMs:(double)ms Skip:(bool)skip;
@end

@interface Scale : ArtemisComponent 
{
    double mX;
    double mY;
}
@property (nonatomic, assign) double X;
@property (nonatomic, assign) double Y;
- (instancetype)initWithX:(double)x Y:(double)y;
@end

@interface Color : ArtemisComponent 
{
    int mR;
    int mG;
    int mB;
    int mA;
}
@property (nonatomic, assign) int R;
@property (nonatomic, assign) int G;
@property (nonatomic, assign) int B;
@property (nonatomic, assign) int A;
- (instancetype)initWithR:(int)r G:(int)g B:(int)b A:(int)a;
@end

@interface Health : ArtemisComponent 
{
    double mCurrent;
    double mMaximum;
}
@property (nonatomic, assign) double Current;
@property (nonatomic, assign) double Maximum;
- (instancetype)initWithCurrent:(double)current Maximum:(double)maximum;
@end

@interface Tween : ArtemisComponent 
{
    double mMin;
    double mMax;
    double mSpeed;
    bool mRepeat;
    bool mActive;
}
@property (nonatomic, assign) double Min;
@property (nonatomic, assign) double Max;
@property (nonatomic, assign) double Speed;
@property (nonatomic, assign) bool Repeat;
@property (nonatomic, assign) bool Active;
- (instancetype)initWithMin:(double)r Max:(double)g Speed:(double)b Repeat:(bool)repeat Active:(bool)active;
@end

@interface Transform : ArtemisComponent 
{
    Texture2D* mTexture;
    SDL_Rect mBounds;
    Vector2D* mPos;
    Vector2D* mScale;
    Vec3 mTint;
    bool mCenter;
}
@property (nonatomic, retain) Texture2D* Texture;
@property (nonatomic, assign) SDL_Rect Bounds;
@property (nonatomic, assign, readonly) SDL_Rect* RefBounds;
@property (nonatomic, retain) Vector2D* Pos;
@property (nonatomic, retain) Vector2D* Scale;
@property (nonatomic, assign) Vec3 Tint;
@property (nonatomic, assign) bool Center;
- (instancetype)initWithTexture:(Texture2D*)texture;
- (instancetype)initWithTexture:(Texture2D*)texture Scale:(double)scale;
- (instancetype)initWithTexture:(Texture2D*)texture Scale:(double)scale Center:(bool)center;
- (void)X:(int)x Y:(int)y W:(int)w H:(int)h;
@end

@interface Identity : ArtemisComponent 
{
    TypeOf mType;
    CategoryOf mCategory;
}
@property (nonatomic, assign) TypeOf Type;
@property (nonatomic, assign) CategoryOf Category;
- (instancetype)initWithType:(TypeOf)type Category:(CategoryOf)category;
@end

@interface Entity : OFObject 
{
    int mId;
    OFString* mName;
    bool mActive;

    Transform* mTransform;
    Identity* mIdentity;
    Sound* mSound;
    // Color* mTint;
    Timer* mExpires;
    Health* mHealth;
    Tween* mTween;
    Vector2D* mVelocity;

    
}
@property (nonatomic, assign) int Id;
@property (nonatomic, retain) OFString* Name;
@property (nonatomic, assign) bool Active;
@property (nonatomic, retain, nullable) Transform* Transform;
@property (nonatomic, retain, nullable) Identity* Identity;
@property (nonatomic, retain, nullable) Sound* Sound;
// @property (nonatomic, retain, nullable) Color* Tint;
@property (nonatomic, retain, nullable) Timer* Expires;
@property (nonatomic, retain, nullable) Health* Health;
@property (nonatomic, retain, nullable) Tween* Tween;
@property (nonatomic, retain, nullable) Vector2D* Velocity;
- (instancetype)initWithId:(int)id Name:(OFString*)name Active:(bool)active;
@end