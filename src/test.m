#import <Foundation/Foundation.h>
#import <xna/xna.h>
#import <artemis/artemis.h>
#import "Components.h"
#import "systems/AnimationSystem.h"
#import "systems/CollisionSystem.h"
#import "systems/InputSystem.h"
#import "systems/PhysicsSystem.h"
#import "systems/RemovalSystem.h"
#import "systems/SpawnSystem.h"

int main(int argc, char *argv[]) 
{

    OFLog("Hello World!");

    let world = [ArtemisWorld new];
	// [world setSystem:[InputSystem inputSystem]];
	[world setSystem:[CollisionSystem collisionSystem]];
    [world initialize];

    // let e1 = [world createEntity];
    // [e1 addComponent:[Player new]];
    // [world addEntity:e1];

    let e2 = [world createEntity];
    [e2 addComponent:[[Health alloc]initWithCurrent:40 Maximum:40]];
    [e2 addComponent:[[Identity alloc]initWithType:TYPE_ENEMY1 Category: CATEGORY_ENEMY]];
    [e2 addComponent:[[Transform alloc]initWithTexture:NULL Scale:2.0]];
    [world addEntity:e2];

    // OFLog(@"e1) %d %d %d %@ %@", e1.Id, [e1 isEnabled], [e1 isActive], e1.componentBits, e1.systemBits);
    OFLog(@"e2) %d %d %d %@ %@", e2.Id, [e2 isEnabled], [e2 isActive], e2.componentBits, e2.systemBits);


    world.delta = 0.01667;
    [world process];

    return 0;
}
