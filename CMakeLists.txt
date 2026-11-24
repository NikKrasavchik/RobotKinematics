cmake_minimum_required(VERSION 3.21)

project(RobotKinematics LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(BUILD_GUI "Build Qt GUI application" ON)

add_subdirectory(core)

if(BUILD_GUI)
    add_subdirectory(app)
endif()