#
#  mafMacroInstallProject.cmake
#  maf
#
#  Created by Daniele Giunchi - Paolo Quadrani on 10/09/10.
#  Copyright 2009 B3C. All rights reserved.
#
#  See Licence at: http://tiny.cc/QXJ4D
#
#

MACRO(mafMacroInstallPlugin)
  set(lib_ext "*")
if(WIN32)
  set(lib_ext "dll")
else(WIN32)
   if(APPLE)
     set(lib_ext "dylib")
   else(APPLE)
     set(lib_ext "so")
   endif(APPLE)
endif(WIN32)

  SET_TARGET_PROPERTIES( ${PROJECT_NAME} PROPERTIES PREFIX "" )
  SET_TARGET_PROPERTIES( ${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_NAME}" )
  
  #rename file and copy directly in mafplugin directory
  add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} ARGS -E  make_directory ${CMAKE_BINARY_DIR}/bin/plugins
          )
   add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} ARGS -E  make_directory ${CMAKE_BINARY_DIR}/bin/Debug/plugins
          )
   add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} ARGS -E  make_directory ${CMAKE_BINARY_DIR}/bin/Release/plugins
          )        

  IF(EXISTS "${CMAKE_BINARY_DIR}/bin/plugins/${PROJECT_NAME}.mafplugin")  
  add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} ARGS -E  remove ${CMAKE_BINARY_DIR}/bin/plugins/${PROJECT_NAME}.mafplugin
          )
  ENDIF(EXISTS "${CMAKE_BINARY_DIR}/bin/plugins/${PROJECT_NAME}.mafplugin")
  
  IF(EXISTS "${CMAKE_BINARY_DIR}/bin/Debug/plugins/${PROJECT_NAME}.mafplugin")  
  add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} ARGS -E  remove ${CMAKE_BINARY_DIR}/bin/Debug/plugins/${PROJECT_NAME}.mafplugin
          )
  ENDIF(EXISTS "${CMAKE_BINARY_DIR}/bin/Debug/plugins/${PROJECT_NAME}.mafplugin")
  
  IF(EXISTS "${CMAKE_BINARY_DIR}/bin/Release/plugins/${PROJECT_NAME}.mafplugin")  
  add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} ARGS -E  remove ${CMAKE_BINARY_DIR}/bin/Release/plugins/${PROJECT_NAME}.mafplugin
          )
  ENDIF(EXISTS "${CMAKE_BINARY_DIR}/bin/Release/plugins/${PROJECT_NAME}.mafplugin")

  IF(EXISTS "${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME}.${lib_ext}")  
  add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} ARGS -E  copy ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME}.${lib_ext} ${CMAKE_BINARY_DIR}/bin/plugins/${PROJECT_NAME}.mafplugin)
  ENDIF(EXISTS "${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME}.${lib_ext}")
  
  IF(EXISTS "${CMAKE_BINARY_DIR}/bin/Debug/${PROJECT_NAME}.${lib_ext}")  
  add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} ARGS -E  copy ${CMAKE_BINARY_DIR}/bin/Debug/${PROJECT_NAME}.${lib_ext} ${CMAKE_BINARY_DIR}/bin/Debug/plugins/${PROJECT_NAME}.mafplugin)
  ENDIF(EXISTS "${CMAKE_BINARY_DIR}/bin/Debug/${PROJECT_NAME}.${lib_ext}")
  
  IF(EXISTS "${CMAKE_BINARY_DIR}/bin/Release/${PROJECT_NAME}.${lib_ext}")  
  add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} ARGS -E  copy ${CMAKE_BINARY_DIR}/bin/Release/${PROJECT_NAME}.${lib_ext} ${CMAKE_BINARY_DIR}/bin/Release/plugins/${PROJECT_NAME}.mafplugin)
  ENDIF(EXISTS "${CMAKE_BINARY_DIR}/bin/Release/${PROJECT_NAME}.${lib_ext}")

  
ENDMACRO()
