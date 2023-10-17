cmake_minimum_required(VERSION 3.14)

project(NQT VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core LinguistTools)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core LinguistTools)

add_library(NQT STATIC nqt.h nqt.cpp)

target_link_libraries(NQT PRIVATE Qt${QT_VERSION_MAJOR}::Core)
target_include_directories(NQT INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

target_compile_definitions(NQT PRIVATE NQT_LIBRARY)

add_subdirectory(NQOrm)
add_subdirectory(NQTranslator)
