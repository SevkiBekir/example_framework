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
install=no
only_install=no

# ---------------------------------------------------------------------------- #
#                                     HELP                                     #
# ---------------------------------------------------------------------------- #

print_help() {
    cat << EOF
This script builds the library

Options:
    --build-type TYPE :Type of build (default Release)
    --build-dir DIR   :Directory in which to build (default ./build):
    --install         :Install the library after building 
    --only-install    :Only install the library
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
    --install)
        shift
        install=yes
        ;;
    --only-install)
        shift
        only_install=yes
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

# Only install the library
if [[ $only_install = yes ]]; then
    install_framework
    exit 0
fi

# Build the library
build

# Install the library
if [[ $install = yes ]]; then
    install_framework
fi