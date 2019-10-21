add_library(shapelib shape.cpp polygon.cpp)

add_executable(DEMO main.cpp)

target_link_libraries(DEMO shapelib)