#import "Systems.h"
#import "Shmupwarz.h"
#define var __auto_type
#define let const var

@implementation Systems;
- (instancetype)initWithGame:(Shmupwarz*)game;
{
    if (self = [super init]) {
        mGame = game;
        mTimeToFire = 0.0;
        mEnemyT1 = 1.0;
        mEnemyT2 = 4.0;
        mEnemyT3 = 6.0;
    }
    return self;
}

/**
 * Draw the entity
 */
- (void) Draw:(SpriteRenderer*) renderer Entity:(Entity*) e {
    if (!e.Active) return;
    var color = (Vec3) { 1, 1, 1 };
    if (e.Tint) {
        color[0] = (float)e.Tint.R/255.0;
        color[1] = (float)e.Tint.G/255.0;
        color[2] = (float)e.Tint.B/255.0;
    }

    [renderer DrawSprite: e.Transform.Texture 
                  Bounds: e.Transform.RefBounds
                  Rotate: 0.0
                   Color: color];


}

/**
 *  Process player input
 */
- (void) Input:(Entity*) entity {
    entity.Transform.Pos.X = mGame.MouseX;
    entity.Transform.Pos.Y = mGame.MouseY;
    if ([mGame GetKey:SDL_SCANCODE_Z] || mGame.MouseDown) {
        mTimeToFire -= mGame.Delta;
        if (mTimeToFire < 0.0) {
            [mGame.Bullets addObject: [[Vector2D alloc]
                initWithX:entity.Transform.Pos.X-27
                        Y:entity.Transform.Pos.Y+2 ]];
            [mGame.Bullets addObject: [[Vector2D alloc]
                initWithX:entity.Transform.Pos.X+27
                        Y:entity.Transform.Pos.Y+2 ]];
            mTimeToFire = FireRate;
        }
    }
}

/**
 *  Trigger enemies
 */
- (void) Spawn:(Entity*) entity {
    mEnemyT1 = [self SpawnEnemy:mGame.Delta T:mEnemyT1 Enemy:1];
    mEnemyT2 = [self SpawnEnemy:mGame.Delta T:mEnemyT2 Enemy:2];
    mEnemyT3 = [self SpawnEnemy:mGame.Delta T:mEnemyT3 Enemy:3];
}

/**
 *  Play sound effects
 */
- (void) Sound:(Entity*) entity {
    if (entity.Active && entity.Sound) {
        Mix_PlayChannelTimed(1, entity.Sound.Chunk, 0, 0);
    }
}

/**
 *  Process physics
 */
- (void) Physics:(Entity*) entity {
    if (entity.Active)
    {
        // Move entity?
        if (entity.Velocity) {
            entity.Transform.Pos.X += entity.Velocity.X * mGame.Delta;
            entity.Transform.Pos.Y += entity.Velocity.Y * mGame.Delta;
        }
        // Set new bounding box
        if (entity.Identity.Category == CATEGORY_BACKGROUND) 
        {
            [entity.Transform 
                X:0 
                Y:0 
                W:mGame.Width 
                H:mGame.Height];
        } 
        else 
        {
            [entity.Transform 
                X:entity.Transform.Pos.X - entity.Transform.Bounds.w / 2.0
                Y:entity.Transform.Pos.Y - entity.Transform.Bounds.h / 2.0
                W:entity.Transform.Texture.Width * entity.Transform.Scale.X
                H:entity.Transform.Texture.Height * entity.Transform.Scale.Y];
        }
    }
}

/**
 *  Process animations
 */
- (void) Tween:(Entity*) entity {
    if (entity.Active && entity.Tween) {

        var x = entity.Transform.Scale.X + (entity.Tween.Speed * mGame.Delta);
        var y = entity.Transform.Scale.Y + (entity.Tween.Speed * mGame.Delta);
        var Active = entity.Tween.Active;

        if (x > entity.Tween.Max) {
            x = entity.Tween.Max;
            y = entity.Tween.Max;
            Active = false;
        } else if (x < entity.Tween.Min) {
            x = entity.Tween.Min;
            y = entity.Tween.Min;
            Active = false;
        }
        entity.Transform.Scale.X = x; 
        entity.Transform.Scale.Y = y; 
        [entity.Transform 
            X:entity.Transform.Pos.X - entity.Transform.Bounds.w / 2.0
            Y:entity.Transform.Pos.Y - entity.Transform.Bounds.h / 2.0
            W:entity.Transform.Texture.Width * entity.Transform.Scale.X
            H:entity.Transform.Texture.Height * entity.Transform.Scale.Y];

        entity.Tween.Active = Active;
    }
}

/**
 *  Clear dead entities
 */
- (void) Kill:(Entity*) entity {
    if (entity.Active) {
        if (entity.Expires) {
            let exp = entity.Expires.Ms - mGame.Delta;
            entity.Expires.Ms = exp;
            if (entity.Expires.Ms < 0) {
                [Factory.Active removeObject:entity];
                entity.Active = false;
            }
        }
        switch(entity.Identity.Category) {
            case CATEGORY_ENEMY:
                if (entity.Transform.Pos.Y > mGame.Height) {
                    [Factory.Active removeObject:entity];
                    entity.Active = false;
                }
                break;
            case CATEGORY_BULLET:
                if (entity.Transform.Pos.Y < 0) {
                    [Factory.Active removeObject:entity];
                    entity.Active = false;
                }
                break;
            default:
                break;
        }

    }
}

/**
 *  Check for collisions
 */
- (void) Collision:(Entity*) entity {
    if (entity.Active && entity.Identity.Category == CATEGORY_ENEMY) {

        for (Entity* bullet in Factory.Health) {
            if (bullet.Active && bullet.Identity.Category == CATEGORY_BULLET) {

                if (SDL_HasIntersection(entity.Transform.RefBounds, bullet.Transform.RefBounds)) {
                    if (entity.Active && bullet.Active) [self HandleCollision:entity Other:bullet];
                    return;
                }
            }
        }
    }
}



/**
 *  Recycle dead entities
 */
- (void) Recycle:(Entity*) entity {
    if (!entity.Active) {
        switch(entity.Identity.Type) {

            case TYPE_BULLET: 
                if ([mGame.Bullets count] > 0) { 
                    Vector2D *bullet = mGame.Bullets[0];
                    [Factory Bullet:entity X:bullet.X Y:bullet.Y];
                    [mGame.Bullets removeObject:bullet];
                }
                break;

            case TYPE_ENEMY1: 
                if ([mGame.Enemies1 count] > 0) { 
                    Vector2D *enemy = mGame.Enemies1[0];
                    [Factory Enemy1:entity X:enemy.X Y:enemy.Y];
                    [mGame.Enemies1 removeObject:enemy];
                }
                break;

            case TYPE_ENEMY2: 
                if ([mGame.Enemies2 count] > 0) { 
                    Vector2D *enemy = mGame.Enemies2[0];
                    [Factory Enemy2:entity X:enemy.X Y:enemy.Y];
                    [mGame.Enemies2 removeObject:enemy];
                }
                break;

            case TYPE_ENEMY3: 
                if ([mGame.Enemies3 count] > 0) { 
                    Vector2D* enemy = mGame.Enemies3[0];
                    [Factory Enemy3:entity X:enemy.X Y:enemy.Y];
                    [mGame.Enemies3 removeObject:enemy];
                }
                break;

            case TYPE_EXPLOSION: 
                if ([mGame.Explosions count] > 0) {
                    Vector2D* exp = mGame.Explosions[0];
                    [Factory Explosion:entity X:exp.X Y:exp.Y];
                    [mGame.Explosions removeObject:exp];
                }
                break;

            case TYPE_BANG: 
                if ([mGame.Bangs count] > 0) {
                    Vector2D* exp = mGame.Bangs[0];
                    [Factory Bang:entity X:exp.X Y:exp.Y];
                    [mGame.Bangs removeObject:exp];
                }
                break;

            case TYPE_PARTICLE: 
                if ([mGame.Particles count] > 0) {
                    Vector2D* exp = mGame.Particles[0];
                    [Factory Particle:entity X:exp.X Y:exp.Y];
                    [mGame.Particles removeObject:exp];
                }
                break;

            default:
                break;
        }
    }
}

/**
 * Spawn an enemy?
 */
- (double) SpawnEnemy:(double) delta T:(double) t Enemy:(int) enemy {
    let d1 = t-delta;
    if (d1 < 0.0) {
        switch(enemy) {
            case 1:
                [mGame.Enemies1 addObject: [[Vector2D alloc]
                    initWithX:(rand() % (mGame.Width-70))+35 Y:35]];
                return 1.0;
            case 2:
                [mGame.Enemies2 addObject: [[Vector2D alloc]
                    initWithX:(rand() % (mGame.Width-170))+85 Y:85]];
                return 4.0;
            case 3:
                [mGame.Enemies3 addObject: [[Vector2D alloc]
                    initWithX:(rand() % (mGame.Width-320))+160 Y:160]];
                return 6.0;
            default:
                return 0;
        }
    } else return d1;    
}

/**
 *  Process collisions
 */
- (void) HandleCollision:(Entity*) a Other:(Entity*) b {
    [mGame.Bangs addObject: [[Vector2D alloc]
        initWithX:b.Transform.Pos.X
                Y:b.Transform.Pos.Y ]];

    b.Active = false;
    [Factory.Active removeObject:b];
    for (int i=0; i<3; i++) {
        [mGame.Particles addObject: [[Vector2D alloc]
            initWithX:b.Transform.Pos.X
                    Y:b.Transform.Pos.Y ]];
    }

    if (a.Health) {
        let h = a.Health.Current - 2;
        if (h < 0) {
            [mGame.Explosions addObject: [[Vector2D alloc]
                initWithX:a.Transform.Pos.X
                        Y:a.Transform.Pos.Y ]];
            a.Active = false;
            [Factory.Active removeObject:a];
        } else {
            a.Health = [[Health alloc]initWithCurrent:h Maximum:a.Health.Maximum];
        }   
    }
}



@end
