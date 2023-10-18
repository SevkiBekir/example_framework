cmake_minimum_required(VERSION 3.21)
project(pyaxelera_framework)

set(PROJECT_DIR ..)


# Add the Python binding code
set(PYBIND11_CPP_STANDARD -std=c++17)
set(PYTON_MODULE ${PROJECT_NAME})
pybind11_add_module(${PROJECT_NAME} ${PROJECT_DIR}/python/axelera_sort_python.cpp)
target_include_directories(${PROJECT_NAME} PUBLIC
                        "${PROJECT_DIR}/include"
                        ${pybind11_INCLUDE_DIRS}
                        ${Python3_INCLUDE_DIRS}
                        )

