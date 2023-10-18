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
build_dir=test_build

# ---------------------------------------------------------------------------- #
#                                     HELP                                     #
# ---------------------------------------------------------------------------- #

print_help() {
    cat << EOF
This script run the unit tests of the library

Options:
    --build-type TYPE :Type of test build (default Release)
    --build-dir DIR   :Directory in which to test build (default ./test_build): 
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
    echo "Building with unit tests..."

    mkdir -p $build_dir
    cd $build_dir
    cmake -DCMAKE_BUILD_TYPE=$build_type -DBUILD_TESTING=ON ..
    make -j$(nproc)
    cd -

    echo "Building with unit tests... - done"
}

run_tests() {
    echo "---------------------------------- TESTING ---------------------------------"
    echo "Running unit tests..."

    cd $build_dir/unit_tests

    # Run the unit tests with memory check
    ctest -T MemCheck \
        --overwrite ValgrindCommand=valgrind \
        --overwrite ValgrindCommandOptions="--leak-check=full --error-exitcode=1 --log-fd=2" \
        --output-on-failure \
        --no-compress-output \
        --output-on-failure-directory $build_dir/unit_tests
    
    cd -

    echo "Running unit tests... - done"
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

# Build the library with the unit tests
build

# Run the unit tests
run_tests