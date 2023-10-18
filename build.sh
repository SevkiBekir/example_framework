#!/bin/bash

set -e

# ---------------------------------------------------------------------------- #
#                                   CONSTANTS                                  #
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
#                                   VARIABLES                                  #
# ---------------------------------------------------------------------------- #
clean=
build_type=Release
build_dir=build

# ---------------------------------------------------------------------------- #
#                                     HELP                                     #
# ---------------------------------------------------------------------------- #

print_help() {
    cat << EOF
This script builds the library

Options:
    --build-type TYPE :Type of build (default Release)
    --build-dir DIR   :Directory in which to build (default ./build): 
    --clean           :Clean the build directory before building

EOF
}

print_usage() {
    echo "$0 [--build-dir DIR] [--clean]"
    echo "$0 --help"
}

print_full_help() {
    print_usage
    print_help
}

# ---------------------------------------------------------------------------- #
#                                   FUNCTIONS                                  #
# ---------------------------------------------------------------------------- #

perform_clean() {
    if [[ $clean = yes ]]; then
        echo "Cleaning..."
        rm -rf $build_dir
        echo "Cleaning... - done"
    fi
}

build() {
    echo "----------------------------------- BUILD ----------------------------------"
    echo "Building..."

    mkdir -p $build_dir
    mkdir -p $build_dir/doc
    cd $build_dir

    cmake -DCMAKE_BUILD_TYPE=$build_type -DBUILD_TESTING=OFF ..
    make -j$(nproc) package
    cd -

    echo "Building... - done"
}

# ---------------------------------------------------------------------------- #
#                                ARGUMENT PARSER                               #
# ---------------------------------------------------------------------------- #

while [ $# -gt 0 ]; do
    case $1 in
    --build-type)
        shift
        build_type=$1
        shift
        ;;
    --build-dir)
        shift
        build_dir=$1
        shift
        ;;
    --clean)
        shift
        clean=yes
        ;;
    -h | --help)
        print_full_help
        exit 0
        ;;
    *)
        break
        ;;
    esac
done

# ---------------------------------------------------------------------------- #
#                                  PREPROCESS                                  #
# ---------------------------------------------------------------------------- #

# Clean build directory
perform_clean

# ---------------------------------------------------------------------------- #
#                                     MAIN                                     #
# ---------------------------------------------------------------------------- #

# Build the library
build