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

#
#   application source
#
set ( APP_SOURCE_FILES
  src/Components.m 
  src/Factory.m 
  src/Shmupwarz.m 
  src/Systems.m 
  src/main.m 
  src/Components/Position.m
  src/Components/Velocity.m
  src/Systems/MovementSystem.m
)


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


target_link_libraries ( ${APP_NAME} m objc gnustep-corebase gnustep-base pthread SDL2 SDL2_image SDL2_mixer SDL2_ttf GL Artemis DarkoGameKit )

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

