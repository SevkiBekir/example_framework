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
PROJECT_DIR=$(pwd)
cpp_tests=no
python_tests=no

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
    --cpp-tests       :Run the C++ unit tests
    --python-tests    :Run the Python binding tests
    --all-tests       :Run all the tests

EOF
}

print_usage() {
    echo "$0 [OPTIONS]"
    echo "$0 --help"
}

print_full_help() {
    print_usage
    print_help
}

# ---------------------------------------------------------------------------- #
#                                   FUNCTIONS                                  #
# ---------------------------------------------------------------------------- #

# Clean build directory
perform_clean() {
    if [[ $clean = yes ]]; then
        echo "Cleaning..."
        rm -rf $build_dir
        echo "Cleaning... - done"
    fi
}

# Build the framework
build() {
    echo "----------------------------------- BUILD ----------------------------------"
    echo "Building with unit tests..."

    mkdir -p $build_dir
    cd $build_dir
    cmake -DCMAKE_BUILD_TYPE=$build_type -DBUILD_TESTING=ON ..
    make -j$(nproc) package
    cd -

    echo "Building with unit tests... - done"
}

# Run the tests
run_tests() {
    echo "---------------------------------- TESTING ---------------------------------"
    echo "Testing..."

    # Run the unit tests
    if [[ $cpp_tests = yes ]]; then
        run_unit_tests
    fi

    # Run the python binding tests
    if [[ $python_tests = yes ]]; then
        run_python_tests
    fi

    echo "Testing... - done"
}

# Run the C++ unit tests
run_unit_tests() {
    echo "------------------------------- UNIT TESTING -------------------------------"
    echo "Running unit tests..."

    cd $build_dir/tests/unit_tests

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

# Run the Python binding tests
run_python_tests() {
    echo "------------------------------ PYTHON TESTS -------------------------------"
    echo "Running python tests..."

    cd $PROJECT_DIR/tests/python_tests

    # Run the python tests
    python3 -m unittest discover -s . -p "test_*.py"

    cd -

    echo "Running python tests... - done"
}

# Install the framework
install_framework() {
    echo "---------------------------------- INSTALL ---------------------------------"
    echo "Installing Axelera Framework package..."

    cd $build_dir
    framework_name=axelera_framework_*
    sudo dpkg -i $framework_name.deb
    cd -

    echo "Installing package... - done"
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
    --cpp-tests)
        shift
        cpp_tests=yes
        ;;
    --python-tests)
        shift
        python_tests=yes
        ;;
    --all-tests)
        shift
        cpp_tests=yes
        python_tests=yes
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

# Install the framework package
install_framework

# Run the unit tests
run_tests