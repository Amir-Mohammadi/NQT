cmake_minimum_required(VERSION 3.14)

project(NQT LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core LinguistTools)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core LinguistTools)

set(TS_FILES NQT_en_US.ts)

add_library(NQT STATIC
  nqt.cpp
  nqt.h
  ${TS_FILES}
)

target_link_libraries(NQT PRIVATE Qt${QT_VERSION_MAJOR}::Core)
target_include_directories(NQT INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

target_compile_definitions(NQT PRIVATE NQT_LIBRARY)

if(COMMAND qt_create_translation)
    qt_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})
else()
    qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})
endif()
