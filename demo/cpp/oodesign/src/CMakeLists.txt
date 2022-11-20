add_library(shapelib shape.cpp polygon.cpp)

add_executable(oodmain main.cpp)

target_link_libraries(oodmain shapelib)