# Link runTests with what we want to test and the GTest and pthread library
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

enable_testing()
include(GoogleTest)

add_executable(oodtest shapelib.t.cpp)
target_link_libraries(oodtest ${GTEST_LIBRARIES} pthread)