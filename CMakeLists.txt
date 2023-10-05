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

  vendor/Artemis/Classes/ObjectiveCExtensions/ArtemisWorld_Debug.h
  vendor/Artemis/Classes/ObjectiveCExtensions/ObjectiveCGenerics.h
  vendor/Artemis/Artemis_Lib.h
  vendor/Artemis/Classes/Artemis.h
  vendor/Artemis/Classes/ArtemisAspect.h
  vendor/Artemis/Classes/ArtemisBag.h
  vendor/Artemis/Classes/ArtemisBitSet.h
  vendor/Artemis/Classes/ArtemisComponent.h
  vendor/Artemis/Classes/ArtemisComponentManager.h
  vendor/Artemis/Classes/ArtemisComponentMapper.h
  vendor/Artemis/Classes/ArtemisComponentType.h
  vendor/Artemis/Classes/ArtemisEntity.h
  vendor/Artemis/Classes/ArtemisEntityManager.h
  vendor/Artemis/Classes/ArtemisEntityObserver.h
  vendor/Artemis/Classes/ArtemisEntitySystem.h
  vendor/Artemis/Classes/ArtemisImmutableBag.h
  vendor/Artemis/Classes/ArtemisManager.h
  vendor/Artemis/Classes/ArtemisWorld.h
  vendor/Artemis/Classes/systems/ArtemisEntityProcessingSystem.h
  vendor/Artemis/Examples/Components/Position.h
  vendor/Artemis/Examples/Components/Velocity.h
  vendor/Artemis/Examples/Systems/MovementSystem.h

)
IF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
	set ( APP_HEADER_FILES "${APP_HEADER_FILES};vendor/Artemis/Classes/CoreFoundation/CFBitVector.h" )
ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")

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

  vendor/Artemis/Artemis_Lib.m
  vendor/Artemis/Classes/ArtemisAspect.m
  vendor/Artemis/Classes/ArtemisBag.m
  vendor/Artemis/Classes/ArtemisBitSet.m
  vendor/Artemis/Classes/ArtemisComponent.m
  vendor/Artemis/Classes/ArtemisComponentManager.m
  vendor/Artemis/Classes/ArtemisComponentMapper.m
  vendor/Artemis/Classes/ArtemisComponentType.m
  vendor/Artemis/Classes/ArtemisEntity.m
  vendor/Artemis/Classes/ArtemisEntityManager.m
  vendor/Artemis/Classes/ArtemisEntitySystem.m
  vendor/Artemis/Classes/ArtemisManager.m
  vendor/Artemis/Classes/ArtemisWorld.m
  vendor/Artemis/Classes/systems/ArtemisEntityProcessingSystem.m
  vendor/Artemis/Examples/Components/Position.m
  vendor/Artemis/Examples/Components/Velocity.m
  vendor/Artemis/Examples/Systems/MovementSystem.m

  src/Components.m 
  src/Factory.m 
  src/Shmupwarz.m 
  src/Systems.m 
  src/main.m 
)

IF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
	set ( APP_SOURCE_FILES "${APP_SOURCE_FILES};vendor/Artemis/Classes/CoreFoundation/CFBitVector.m" )
ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")


#
#   application includes
#
set ( INCLUDES "${INCLUDES};/usr/include" )
set ( INCLUDES "${INCLUDES};/usr/include/SDL2" )
set ( INCLUDES "${INCLUDES};/usr/GNUstep/Local/Library/Headers" )
set ( INCLUDES "${INCLUDES};/usr/local/include" )
set ( INCLUDES "${INCLUDES};/usr/local/include/SDL2" )
set ( INCLUDES "${INCLUDES};/usr/local/GNUstep/System/Library/Headers" )
set ( INCLUDES "${INCLUDES};./vendor" )
set ( INCLUDES "${INCLUDES};./include" )
#
#   compiler options
#

set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -O2" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -pipe" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -std=c18" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -Wall" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -Wno-psabi" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -Wno-import" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -Wno-nullability-completeness" )

IF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
	set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fobjc-runtime=gnustep-2.0" )
ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")

IF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
	set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fobjc-runtime=gnustep-2.1" )
ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")

set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fblocks" )
# set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fobjc-arc" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fexceptions" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fobjc-exceptions" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fPIC" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fstack-protector-strong" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fno-strict-aliasing" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -fconstant-string-class=NSConstantString" )

IF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
	set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -DOBJC_RUNTIME=20" )
ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")

IF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
	set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -DOBJC_RUNTIME=21" )
ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")

set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -DGNUSTEP" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -DGNUSTEP_BASE_LIBRARY=1" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -DGNU_GUI_LIBRARY=1" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -DGNUSTEP_RUNTIME=1" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -D_NONFRAGILE_ABI=1" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -D_NATIVE_OBJC_EXCEPTIONS" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -DGSWARN" )
set ( CMAKE_OBJC_FLAGS "${CMAKE_OBJC_FLAGS} -DGSDIAGNOSE" )


# Libs: 
link_directories ( "/usr/lib" )
link_directories ( "/usr/GNUstep/Local/Library/Libraries" )
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


target_link_libraries ( ${APP_NAME} m objc gnustep-corebase gnustep-base pthread SDL2 SDL2_image SDL2_mixer SDL2_ttf GL  )

add_custom_command ( TARGET ${APP_NAME} PRE_BUILD
                      COMMAND ${CMAKE_COMMAND} -E copy_directory
                        ${CMAKE_SOURCE_DIR}/Resources/ $<TARGET_FILE_DIR:${APP_NAME}>/Resources )

add_custom_command ( TARGET ${APP_NAME} PRE_BUILD
                      COMMAND ${CMAKE_COMMAND} -E copy
                        ${CMAKE_SOURCE_DIR}/${APP_NAME}Info.plist $<TARGET_FILE_DIR:${APP_NAME}>/Resources )
   
IF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
  install ( TARGETS ${APP_NAME} RUNTIME DESTINATION /Applications/Games/${APP_NAME}.app )
  install ( DIRECTORY Resources DESTINATION /Applications/Games/${APP_NAME}.app )
  install ( FILES ${APP_NAME}Info.plist DESTINATION /Applications/Games/${APP_NAME}.app/Resources )
ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")

IF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  install ( TARGETS ${APP_NAME} RUNTIME DESTINATION /usr/GNUstep/Local/Applications/${APP_NAME}.app )
  install ( DIRECTORY Resources DESTINATION /usr/GNUstep/Local/Applications/${APP_NAME}.app )
  install ( FILES ${APP_NAME}Info.plist DESTINATION /usr/GNUstep/Local/Applications/${APP_NAME}.app/Resources )
ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")


include ( CPack )

