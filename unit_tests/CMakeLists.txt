cmake_minimum_required(VERSION 3.21)
project(test_axelera_lib)

# Find Google Test
find_package(GTest REQUIRED)

set(PROJECT_DIR ..)

set(test_sort test_axelera_sort)
add_executable(${test_sort} test_axelera_sort.cpp)
target_compile_options(${test_sort} PRIVATE -Wall -Werror -DLIBRARY_TESTING)
target_link_libraries(${test_sort} PRIVATE  GTest::GTest GTest::Main axelera_lib)
target_include_directories(${test_sort} PRIVATE ${PROJECT_DIR}/include)

include_directories(${PROJECT_DIR} ${CMAKE_CURRENT_BINARY_DIR})

add_test(NAME ${test_sort} COMMAND ${test_sort})


include(CTest)
