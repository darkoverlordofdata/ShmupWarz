#import <XCore.h>
#import <xna/xna.h>
#import "Systems.h"
#import "Components.h"
#import "Factory.h"

@class Systems;

@interface Shmupwarz : Game 
{
    Entity* mPlayer;
    Systems*  mSystems;

}
@property (nonatomic) float delta;
@property (nonatomic, readonly, retain) Systems* System;
@property (class, nonatomic, retain, readonly) Shmupwarz* Instance;

- (instancetype)initWithWidth:(int)width 
                       Height:(int)height;
- (NSString*)description;
- (void)SetSystem:(Systems*)systems;
- (void)Initialize;
- (void)LoadContent;
- (void)Update:(GLfloat) delta;
- (void)Draw:(GLfloat) delta;
- (Entity*)GetEntity:(int)index;

@end