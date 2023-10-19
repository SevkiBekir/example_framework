cmake_minimum_required(VERSION 3.21)
project(pyaxelera_framework)

set(PROJECT_DIR ..)


# Add the Python binding code
set(PYTHON_MODULE ${PROJECT_NAME})

# Create the Python extension module as a static library
pybind11_add_module(${PYTHON_MODULE} MODULE ${PROJECT_DIR}/python/axelera_sort_python.cpp)

# Link the Python module to the C++ library containing your Sort class
target_link_libraries(${PYTHON_MODULE} PRIVATE axelera_framework)  # Replace with your actual library name


# Set the include directories
target_include_directories(${PYTHON_MODULE} PUBLIC
    "${PROJECT_DIR}/include"
    ${pybind11_INCLUDE_DIRS}
    ${Python3_INCLUDE_DIRS}
)

# If you want to install the Python module, you can keep the install logic
if(LIB_DEB_PACKAGE)
    install(TARGETS ${PYTHON_MODULE}
        COMPONENT ${PROJECT_NAME}
        DESTINATION /usr/lib/python3/dist-packages
    )
endif()