cmake_minimum_required(VERSION 3.21)

# Set the project name
project(test_axelera_framework LANGUAGES CXX)

# Find Google Test
find_package(GTest REQUIRED)

# Set the project directory
set(PROJECT_DIR ..)

# Set the test executable
# Axelera Sort Test
set(test_sort test_axelera_sort)
add_executable(${test_sort} test_axelera_sort.cpp)
target_compile_options(${test_sort} PRIVATE -Wall -Werror -DLIBRARY_TESTING)
target_link_libraries(${test_sort} PRIVATE  GTest::GTest GTest::Main axelera_framework)
target_include_directories(${test_sort} PRIVATE ${PROJECT_DIR}/include)

include_directories(${PROJECT_DIR} ${CMAKE_CURRENT_BINARY_DIR})

# Add the test to CTest
add_test(NAME ${test_sort} COMMAND ${test_sort})

# Enable CTest
include(CTest)
