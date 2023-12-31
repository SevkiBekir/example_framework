cmake_minimum_required(VERSION 3.21)
# Set the project name
project(axelera_framework LANGUAGES CXX)

# Options
option(LIB_DEB_PACKAGE "CMake code to build debian package" ON)
option(BUILD_TESTING "Build unit tests" OFF)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)

# Find Python3 and Pybind11
find_package(Python3 REQUIRED COMPONENTS Interpreter Development)
find_package(pybind11 REQUIRED)

# Add the C++ source files
file(GLOB_RECURSE SOURCES ${PROJECT_SOURCE_DIR}/src/*.cpp)
file(GLOB_RECURSE HEADERS ${PROJECT_SOURCE_DIR}/include/*.h)
list(APPEND ALL_SRCS ${SOURCES} ${HEADERS})

# Create a library
add_library(${PROJECT_NAME} STATIC ${SOURCES} ${HEADERS})

# Set compiler flags
target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Werror)

# Include Pybind11 headers
target_include_directories(${PROJECT_NAME} PUBLIC
        "${PROJECT_SOURCE_DIR}/include"
        ${pybind11_INCLUDE_DIRS}
        ${Python3_INCLUDE_DIRS}
        )

# Link Python and Pybind11 libraries
target_link_libraries(${PROJECT_NAME} PUBLIC
        Python3::Python
        ${pybind11_LIBRARIES}
        )

# Add the Python binding code
add_subdirectory(python)

if(BUILD_TESTING)
    # Add unit tests
    enable_testing()
    add_subdirectory(tests)
endif()

# Install the framework
if(LIB_DEB_PACKAGE)
    # install framework
    install(FILES ${CMAKE_BINARY_DIR}/lib${PROJECT_NAME}.a
    DESTINATION /usr/lib
    COMPONENT ${PROJECT_NAME})

    # install headers
    install(FILES
        ${PROJECT_SOURCE_DIR}/include/axelera_sort.h
    
        DESTINATION /usr/include
        COMPONENT ${PROJECT_NAME})

    # take version number for the package from a file that contains release version
    file (STRINGS "version.txt" VERSION)

    # create a debian package
    set(CPACK_GENERATOR DEB)
    set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
    set(CPACK_DEBIAN_PACKAGE_VERSION ${VERSION})
    set(CPACK_DEBIAN_PACKAGE_DESCRIPTION
    "This library contains sorting algorithms required to develop Example SDK.")
    SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "Example Inc, Infrastructure Team <info@example.com>")
    include(CPack)
endif()




# Doxygen documentation
find_package(Doxygen REQUIRED)

if(DOXYGEN_FOUND)
    # set input and output files
    set(DOXYGEN_IN ${CMAKE_CURRENT_SOURCE_DIR}/doc/Doxyfile)
    set(DOXYGEN_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)

    # request to configure the file
    configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)

    # note the option ALL which allows to build the docs together with the framework
    add_custom_target(docs ALL
        COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/include
        COMMENT "Generating documentation with Doxygen"
        VERBATIM
    )

    # install the documentation
    install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/doc/html
        DESTINATION ${CMAKE_INSTALL_PREFIX}/share/doc
    )
endif()
