cmake_minimum_required(VERSION 3.21)

# Set the project name
project(pyaxelera_framework LANGUAGES CXX)

# Set the C++ standard
set(PROJECT_DIR ..)

# Add the Python binding code
set(PYTHON_MODULE ${PROJECT_NAME})

# Create the Python extension module as a static library
pybind11_add_module(${PYTHON_MODULE} MODULE ${PROJECT_DIR}/python/axelera_sort_python.cpp)

# Link the Python module to the C++ library containing Axelera Sort class
target_link_libraries(${PYTHON_MODULE} PRIVATE axelera_framework)


# Set the include directories
target_include_directories(${PYTHON_MODULE} PUBLIC
    "${PROJECT_DIR}/include"
    ${pybind11_INCLUDE_DIRS}
    ${Python3_INCLUDE_DIRS}
)

# Install the Python module
if(LIB_DEB_PACKAGE)
    install(TARGETS ${PYTHON_MODULE}
        COMPONENT ${PROJECT_NAME}
        DESTINATION /usr/lib/python3/dist-packages
    )
endif()