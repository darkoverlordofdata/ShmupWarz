#
# use cmake to build for debugging
#
# use gmake to build the release app bundle
#
include $(GNUSTEP_MAKEFILES)/common.make

CC = clang
CXX = clang++

APP_NAME = Shmupwarz


Shmupwarz_HEADERS = include/Components.h \
					include/Factory.h \
					include/Shmupwarz.h \
					include/Systems.h \
					include/Components/Position.h \
					include/Components/Velocity.h \
					include/Systems/MovementSystem.h \
					vendor/xna/Game.h \
					vendor/xna/OpenGL.h \
					vendor/xna/content/ResourceManager.h \
					vendor/xna/graphics/Shader.h \
					vendor/xna/graphics/SpriteRenderer.h \
					vendor/xna/graphics/Texture2D.h 



Shmupwarz_OBJC_FILES = 	src/main.m \
					src/Components.m \
					src/Factory.m \
					src/Shmupwarz.m \
					src/Systems.m \
					src/Components/Position.m \
					src/Components/Velocity.m \
					src/Systems/MovementSystem.m \
					vendor/xna/Game.m \
					vendor/xna/OpenGL.m \
					vendor/xna/content/ResourceManager.m \
					vendor/xna/graphics/Shader.m \
					vendor/xna/graphics/SpriteRenderer.m \
					vendor/xna/graphics/Texture2D.m 



Shmupwarz_RESOURCE_FILES = ShmupwarzInfo.plist \
							Resources/Shmupwarz.png \
							Resources/background.png \
							Resources/bang.png \
							Resources/bullet.png \
							Resources/enemy1.png \
							Resources/enemy2.png \
							Resources/enemy3.png \
							Resources/explosion.png \
							Resources/particle.png \
							Resources/spaceshipspr.png \
							Resources/star.png \
							Resources/sprite.vs \
							Resources/sprite.frag \
							Resources/particle.vs \
							Resources/particle.frag 
							


OBJCFLAGS=  -I./vendor \
			-I./include \
			-I/usr/include \
			-I/usr/include/SDL2 \
			-I/usr/local/include \
			-I/usr/local/include/SDL2 \
			-Wno-nullability-completeness \
			-std=c18 \


_SYS := $(shell uname 2>/dev/null || echo Unknown)

ifeq ($(_SYS),Linux)
OBJCFLAGS+=	-DOBJC_RUNTIME=21
endif

ifeq ($(_SYS),FreeBSD)
OBJCFLAGS+=	-DOBJC_RUNTIME=20
endif

			
CFLAGS= 	-std=c18

LDFLAGS=  -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lgnustep-corebase -lartemis


-include GNUmakefile.preamble

-include GNUmakefile.local

include $(GNUSTEP_MAKEFILES)/application.make

-include GNUmakefile.postamble



