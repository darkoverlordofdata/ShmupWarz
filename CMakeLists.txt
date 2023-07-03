cmake_minimum_required ( VERSION 3.16 )
###################################################################################
#
#   Build shmupwarz
#
###################################################################################
###################################################################################
#
#   Experimental cmake build for CMake Tools tooling
#
###################################################################################
project ( shmupwarz VERSION 0.0.1 )
enable_language( OBJC )

#
set ( VERSION 0.0.1 )
set ( RELEASE_NAME shmupwarz )
set ( PROJECT_NAME shmupwarz )
set ( APP_NAME "Shmupwarz" )
set ( CMAKE_EXPORT_COMPILE_COMMANDS ON )
#
# enable features
#
include ( CMakeToolsHelpers OPTIONAL )

set ( APP_HEADER_FILES
  include/Components.h 
  include/Factory.h 
  include/Shmupwarz.h 
  include/Systems.h 
  vendor/xna/Game.h 
  vendor/xna/OpenGL.h 
  vendor/xna/content/ResourceManager.h 
  vendor/xna/graphics/Shader.h 
  vendor/xna/graphics/SpriteRenderer.h 
  vendor/xna/graphics/Texture2D.h
)

#
#   application source
#
set ( APP_SOURCE_FILES
  vendor/xna/Game.m 
  vendor/xna/OpenGL.m 
  vendor/xna/content/ResourceManager.m 
  vendor/xna/graphics/Shader.m 
  vendor/xna/graphics/SpriteRenderer.m 
  vendor/xna/graphics/Texture2D.m 
  src/Components.m 
  src/Factory.m 
  src/Shmupwarz.m 
  src/Systems.m 
  src/main.m 
)



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
# set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fobjc-arc" )
# set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fblocks" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fobjc-runtime=gnustep-2.0" )
# set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fexceptions" )
# set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fobjc-exceptions" )
# set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -funwind-tables" )
# set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -w -std=c18 -O3" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -std=c18 -Wno-nullability-completeness" )


link_directories ( "/usr/local/lib" )
link_directories ( "/usr/local/GNUstep/System/Library/Libraries" )

# definitions 
include_directories ( AFTER ${INCLUDES} )

#
#   compile ccode & link executable
#
add_executable (
    ${APP_NAME}
    ${APP_HEADER_FILES}
    ${APP_SOURCE_FILES}
)


target_link_libraries ( ${APP_NAME} m objc gnustep-base pthread SDL2 SDL2_image SDL2_mixer SDL2_ttf GL  )

add_custom_command ( TARGET ${APP_NAME} PRE_BUILD
                      COMMAND ${CMAKE_COMMAND} -E copy_directory
                        ${CMAKE_SOURCE_DIR}/Resources/ $<TARGET_FILE_DIR:${APP_NAME}>/Resources )

add_custom_command ( TARGET ${APP_NAME} PRE_BUILD
                      COMMAND ${CMAKE_COMMAND} -E copy
                        ${CMAKE_SOURCE_DIR}/${APP_NAME}Info.plist $<TARGET_FILE_DIR:${APP_NAME}>/Resources )
   
install ( TARGETS ${APP_NAME} RUNTIME DESTINATION /Applications/Games/${APP_NAME}.app )
install ( DIRECTORY Resources DESTINATION /Applications/Games/${APP_NAME}.app )
install ( FILES ${APP_NAME}Info.plist DESTINATION /Applications/Games/${APP_NAME}.app/Resources )

include ( CPack )

