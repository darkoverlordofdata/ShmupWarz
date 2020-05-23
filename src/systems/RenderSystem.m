#import "systems/RenderSystem.h"
#import "Components.h"

// #import "ArtemisComponentMapper.h"

@interface RenderSystem()
@property(nonatomic,retain) ArtemisComponentMapper* transformMapper;
@property(nonatomic,retain) ArtemisComponentMapper* identityMapper;
@property(nonatomic,retain) SpriteRenderer* renderer;
@end

@implementation RenderSystem

+(RenderSystem *)renderSystem
{
	RenderSystem* m = [[RenderSystem alloc] initWithAspect:[ArtemisAspect aspectForAll:@[ [Transform class] ]]];
	
	return m;
}

-(void)initialize
{
    NSLog(@"RenderSystem::initialize");
    self.renderer = [[SpriteRenderer alloc]initWithShader:[ResourceManager GetShader:@"sprite"]];
	self.transformMapper = [ArtemisComponentMapper componentMapperForType:[Transform class] inWorld:self.world];
	// self.identityMapper = [ArtemisComponentMapper componentMapperForType:[Identity class] inWorld:self.world];
}

-(void)process:(ArtemisEntity *)entity
{
    // NSLog(@"RenderSystem::process");
    // if (!entity.isActive) return;
	Transform* transform = (Transform*) [self.transformMapper get:entity];
    if (transform.Texture == nil) {
        NSLog(@"RenderSystem %@ %d", entity, entity.isActive);
        // NSLog(@"renderer %x", self.renderer);
        // NSLog(@"transform.Tint %f,%f,%f", transform.Tint.x, transform.Tint.y, transform.Tint.z);
        // NSLog(@"transform.Texture %x", transform.Texture);
        // NSLog(@"transform.Bounds %d,%d,%d,%d", transform.Bounds.x, transform.Bounds.y, transform.Bounds.w, transform.Bounds.h);
        // return;
    }
    // Identity* identity = (Identity*) [self.identityMapper get:entity];


    // Set new bounding box
    if (transform.Center) 
    {
        [transform 
            X:transform.Pos.X - transform.Bounds.w / 2
            Y:transform.Pos.Y - transform.Bounds.h / 2
            W:transform.Texture.Width * transform.Scale.X
            H:transform.Texture.Height * transform.Scale.Y];
    }

    [self.renderer DrawSprite: transform.Texture 
                  Bounds: transform.Bounds
                  Rotate: 0.0
                   Color: transform.Tint];

}

@end
