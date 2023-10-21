#!/bin/bash

set -e
# ---------------------------------------------------------------------------- #
#                                   CONSTANTS                                  #
# ---------------------------------------------------------------------------- #

IMAGE_NAME="axelera"

# ---------------------------------------------------------------------------- #
#                                   VARIABLES                                  #
# ---------------------------------------------------------------------------- #

# Ubuntu base containers for different architectures
# The base containers are used to build the docker image
# NOTE: Currently only amd64 is supported
base_containers=(
    ["amd64"]="amd64/ubuntu:jammy"
)

verbose="--quiet"
image_tag="build"
tty="-it"
full_image_name=""
arch=amd64
env_args=""
volumes=""
version=""
# ---------------------------------------------------------------------------- #
#                                     HELP                                     #
# ---------------------------------------------------------------------------- #

print_help() {
    cat << EOF
This script builds docker image and runs the container based on the image

Options:
    -v, --verbose: Enable showing the verbose information while building docker image
    -g, --github: Run the script based on GitHub
    -t, --tag: Tag the docker image. Default is 'build'
    -a, --arch: Architecture of the base image. Default is 'amd64'
    -e, --env: Environment variables to be passed to the docker container
    --volume: Volumes to be mounted to the docker container

EOF
}

print_usage() {
    echo "$0 [OPTIONS] <SCRIPT_TO_BE_RUN>"
    echo "$0 --help"
}

print_full_help() {
    print_usage
    print_help
}

# ---------------------------------------------------------------------------- #
#                                   FUNCTIONS                                  #
# ---------------------------------------------------------------------------- #

# Set full image name
set_full_image_name() {
    full_image_name="${IMAGE_NAME}:${image_tag}"
}

# Build docker image
build_docker() {
    echo "Docker building..."
    build_args="--build-arg DOCKER_IMAGE=${base_image}"
    echo "Pulling base image: $base_image"
    docker pull $base_image

    echo "Building docker image from $base_image..."
    docker build $verbose \
        $build_args \
        -f docker/Dockerfile \
        -t $full_image_name \
        docker
    echo "Docker building... - done"
}

# Run docker container
run_docker() {
    echo "Docker running..."
    container_name="${IMAGE_NAME}_${image_tag}_${arch}_${version}"
    working_dir="/share/axelera"

    docker run --rm $tty \
        $env_args \
        $volumes \
         -v $(pwd):$working_dir \
        --name $container_name \
        -w $working_dir \
        $full_image_name \
        $@

    echo "Docker running... - done"
}

# Set version of the framework
set_version(){
    version=$(cat version.txt)
}

# Set base image
set_base_image(){
    base_image=${base_containers[$arch]}
}

# ---------------------------------------------------------------------------- #
#                                ARGUMENT PARSER                               #
# ---------------------------------------------------------------------------- #

while [ $# -gt 0 ]; do
    case $1 in
    -v | --verbose)
        verbose=""
        shift
        ;;
    -g | --github)
        tty="-t"
        shift
        ;;
    -t | --tag)
        shift
        image_tag=$1
        shift
        ;;
    -a | --arch)
        shift
        arch=$1
        shift
        ;;
    -e | --env)
        shift
        env_args="${env_args} -e $1"
        shift
        ;;
    --volume)
        shift
        volumes="${volumes} -v $1"
        shift
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

# set version of the framework
set_version

# set base image
set_base_image

# set docker image full name
set_full_image_name

# ---------------------------------------------------------------------------- #
#                                     MAIN                                     #
# ---------------------------------------------------------------------------- #

# build docker image
build_docker

# run docker container
run_docker $@