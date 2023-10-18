cmake_minimum_required(VERSION 3.21)
project(axelera_lib)


option(LIB_DEB_PACKAGE "CMake code to build debian package" ON)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)

# Find Python3 and Pybind11
find_package(Python3 REQUIRED COMPONENTS Interpreter Development)
find_package(pybind11 REQUIRED)

# Add the C++ source files
file(GLOB_RECURSE SOURCES ${PROJECT_SOURCE_DIR}/*.cpp)
file(GLOB_RECURSE HEADERS ${PROJECT_SOURCE_DIR}/*.h)
list(APPEND ALL_SRCS ${SOURCES} ${HEADERS})

# Create a library
add_library(${PROJECT_NAME} STATIC ${SOURCES} ${HEADERS})

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

if(BUILD_TESTING)
    # Build and run tests using add_subdirectory
    # add_subdirectory(tests)
endif()

if(LIB_DEB_PACKAGE)
    install(FILES ${CMAKE_BINARY_DIR}/lib${PROJECT_NAME}.a
    DESTINATION /usr/lib
    COMPONENT ${PROJECT_NAME})

    install(FILES
        ${PROJECT_SOURCE_DIR}/include/ax_sort.h
    
        DESTINATION /usr/include
        COMPONENT ${PROJECT_NAME})

    # take version number for the package from a file that contains release version
    file (STRINGS "version.txt" VERSION)

    set(CPACK_GENERATOR DEB)
    set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
    set(CPACK_DEBIAN_PACKAGE_VERSION ${VERSION})
    set(CPACK_DEBIAN_PACKAGE_DESCRIPTION
    "This library contains sorting algorithms required to develop a Axelera Voyager SDK.")
    SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "Axelera AI, Infrastructure Team <infra-dev@axelera.ai>")
    include(CPack)
endif()




# Doxygen documentation (optional)
# find_package(Doxygen)

# if(DOXYGEN_FOUND)
#     doxygen_add_docs(doxygen
#             "${CMAKE_CURRENT_SOURCE_DIR}/src"
#             "${CMAKE_CURRENT_SOURCE_DIR}/include"
#             COMMENT "Generate documentation"
#             )
# endif()