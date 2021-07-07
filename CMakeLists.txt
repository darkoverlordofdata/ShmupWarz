cmake_minimum_required ( VERSION 3.1 )
###################################################################################
#
#   Build shmupwarz
#
###################################################################################
###################################################################################
#
#   Experimental cmake build for CMake Tools toolingk
#   Execute first: ./configure 
#   cd build
#   make
#   ./shmupwarz or use F5 to debug.
#
#   gmake to distribute
#
###################################################################################
project ( shmupwarz VERSION 0.0.1 )

#
set ( VERSION 0.0.1 )
set ( RELEASE_NAME shmupwarz )

#
# enable features
#
include ( CMakeToolsHelpers OPTIONAL )

#
#   application source
#
list ( APPEND C_SOURCES vendor/xna/Game.m )
list ( APPEND C_SOURCES vendor/xna/content/ResourceManager.m )
list ( APPEND C_SOURCES vendor/xna/graphics/Shader.m )
list ( APPEND C_SOURCES vendor/xna/graphics/SpriteRenderer.m )
list ( APPEND C_SOURCES vendor/xna/graphics/Texture2D.m )
list ( APPEND C_SOURCES src/Components.m )
list ( APPEND C_SOURCES src/Factory.m )
list ( APPEND C_SOURCES src/Shmupwarz.m )
list ( APPEND C_SOURCES src/Systems.m )
list ( APPEND C_SOURCES src/main.m )
#
#   application includes
#
set ( INCLUDES "${INCLUDES};/usr/local/include" )
set ( INCLUDES "${INCLUDES};/usr/local/include/SDL2" )
set ( INCLUDES "${INCLUDES};./vendor" )
set ( INCLUDES "${INCLUDES};./include" )
set ( INCLUDES "${INCLUDES};/usr/local/GNUstep/System/Library/Headers" )

#
#   compiler options
#
# Libs: 
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fobjc-arc" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fblocks" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fobjc-runtime=gnustep-2.0" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fexceptions" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fobjc-exceptions" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -funwind-tables" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -L/usr/local/lib" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -L/usr/local/GNUstep/System/Library/Libraries" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -w -std=c18 -O3" )

# definitions 
include_directories(AFTER ${INCLUDES})

#
#   compile ccode & link executable
#
add_executable ( ${PROJECT_NAME} ${C_SOURCES} ${RESOURCES} )

target_link_libraries ( ${PROJECT_NAME} m objc gnustep-base pthread SDL2 SDL2_image SDL2_mixer SDL2_ttf GL  )
install (TARGETS ${PROJECT_NAME} RUNTIME DESTINATION . )

include (CPack)

