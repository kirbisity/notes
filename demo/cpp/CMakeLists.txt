cmake_minimum_required(VERSION 3.14)

project(demo)

set (CMAKE_CXX_STANDARD 11)

find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

enable_testing()
include(GoogleTest)

add_subdirectory(src)
add_subdirectory(test)