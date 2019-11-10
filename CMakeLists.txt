cmake_minimum_required ( VERSION 3.1 )
###################################################################################
#
#   Build shmupwarz
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
# list ( APPEND C_SOURCES src/test.m )
#
#   application includes
#0
set ( INCLUDES "${INCLUDES};/usr/include" )
set ( INCLUDES "${INCLUDES};./vendor" )
set ( INCLUDES "${INCLUDES};./include" )


#
#   compiler options
#
# Libs: 
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -lm" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -lobjfw" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -lobjfwrt" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -lpthread" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -lSDL2" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -lSDL2_image" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -lSDL2_mixer" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -lSDL2_ttf" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -lGL" )


set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fexceptions" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fobjc-exceptions" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -funwind-tables" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fconstant-string-class=OFConstantString" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Xclang -fobjc-arc" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Xclang -fno-constant-cfstrings" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Xclang -fobjc-runtime=objfw" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Xclang -fblocks" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -L/usr/local/lib" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -w -std=c18 -O3" )

# definitions 

include_directories(AFTER ${INCLUDES})

#
#   compile ccode & link executable
#
add_executable ( ${PROJECT_NAME} ${C_SOURCES} ${RESOURCES} )

target_link_libraries ( ${PROJECT_NAME} m objfw objfwrt pthread SDL2 SDL2_image SDL2_mixer SDL2_ttf GL  )
install (TARGETS ${PROJECT_NAME} RUNTIME DESTINATION . )

include (CPack)

