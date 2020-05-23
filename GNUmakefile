GNUSTEP_INSTALLATION_DOMAIN = USER

include $(GNUSTEP_MAKEFILES)/common.make

# The application to be compiled
APP_NAME = Demo

# The Objective-C source files to be compiled

Demo_HEADER_FILES = vendor/xna/OpenGL.h \
                    vendor/xna/Game.h \
                    vendor/xna/content/ResourceManager.h \
                    vendor/xna/graphics/Shader.h \
                    vendor/xna/graphics/SpriteRenderer.h \
                    vendor/xna/graphics/Texture2D.h \
                    vendor/artemis/util/ArtemisImmutableBag.h \
                    vendor/artemis/util/ArtemisBag.h\
                    vendor/artemis/util/ArtemisBitSet.h \
                    vendor/artemis/core/ArtemisAspect.h \
                    vendor/artemis/core/ArtemisComponent.h \
                    vendor/artemis/core/ArtemisComponentManager.h \
                    vendor/artemis/core/ArtemisComponentMapper.h \
                    vendor/artemis/core/ArtemisComponentType.h \
                    vendor/artemis/core/ArtemisEntity.h \
                    vendor/artemis/core/ArtemisEntityManager.h \
                    vendor/artemis/core/ArtemisEntityObserver.h \
                    vendor/artemis/core/ArtemisEntitySystem.h \
                    vendor/artemis/core/ArtemisManager.h \
                    vendor/artemis/core/ArtemisWorld.h \
                    vendor/artemis/systems/ArtemisEntityProcessingSystem.m \
                    include/Components.h \
                    include/Factory.h \
                    include/Shmupwarz.h \
                    include/systems/AnimationSystem.h \
                    include/systems/CollisionSystem.h \
                    include/systems/InputSystem.h \
                    include/systems/PhysicsSystem.h \
                    include/systems/RemovalSystem.h \
                    include/systems/RenderSystem.h \
                    include/systems/SpawnSystem.h \

Demo_OBJC_FILES =   vendor/xna/Game.m \
                    vendor/xna/content/ResourceManager.m \
                    vendor/xna/graphics/Shader.m \
                    vendor/xna/graphics/SpriteRenderer.m \
                    vendor/xna/graphics/Texture2D.m \
                    vendor/artemis/util/ArtemisBag.m \
                    vendor/artemis/util/ArtemisBitSet.m \
                    vendor/artemis/core/ArtemisAspect.m \
                    vendor/artemis/core/ArtemisComponent.m \
                    vendor/artemis/core/ArtemisComponentManager.m \
                    vendor/artemis/core/ArtemisComponentMapper.m \
                    vendor/artemis/core/ArtemisComponentType.m \
                    vendor/artemis/core/ArtemisEntity.m \
                    vendor/artemis/core/ArtemisEntityManager.m \
                    vendor/artemis/core/ArtemisEntitySystem.m \
                    vendor/artemis/core/ArtemisManager.m \
                    vendor/artemis/core/ArtemisWorld.m \
                    vendor/artemis/systems/ArtemisEntityProcessingSystem.m \
                    src/Components.m \
                    src/Factory.m \
                    src/Shmupwarz.m \
                    src/systems/AnimationSystem.m \
                    src/systems/CollisionSystem.m \
                    src/systems/InputSystem.m \
                    src/systems/PhysicsSystem.m \
                    src/systems/RemovalSystem.m \
                    src/systems/RenderSystem.m \
                    src/systems/SpawnSystem.m \
                    src/main.m 

SHARED_CFLAGS     += -g -fobjc-arc

OBJCFLAGS=`pkg-config --cflags sdl2` `pkg-config --cflags SDL2_image` `pkg-config --cflags SDL2_mixer` `pkg-config --cflags SDL2_ttf` -I./vendor -I./include
LDFLAGS=`pkg-config --libs sdl2` `pkg-config --libs SDL2_image` `pkg-config --libs SDL2_mixer` `pkg-config --libs SDL2_ttf`

# The Resource files to be copied into the app's resources directory// Demo_RESOURCE_FILES = Icons/*

-include GNUmakefile.preamble

-include GNUmakefile.local

include $(GNUSTEP_MAKEFILES)/application.make

-include GNUmakefile.postamble
