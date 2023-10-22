[![Axelera Framework CI/CD](https://github.com/SevkiBekir/axelera/actions/workflows/main.yml/badge.svg)](https://github.com/SevkiBekir/axelera_framework/actions/workflows/main.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Static Badge](https://img.shields.io/badge/version-1.0.0-red)


# Axelera Framework
It's solution of the problem which is given by Axelera's AI team.  

The problem is below.

## Problem
Write the build and test system for the following library:

We want to write an “efficient” python library that takes an array of numbers and sorts them.

We want  the “compute” intensive part to be implemented in C/C++ while provide python bindings so that our library can be called by our ML engineer who is not C/C++ experienced

## Solution
### Introduction
The framework, called `AxeleraFramework` has C++ function which is sorting the given array, and python bindings to call C++ function from python. The framework has unit tests which are testing the C++ function, and python tests which are testing the python bindings. All of operations in the framework are running in docker container. The framework is also integrated with Github Actions CI/CD pipeline.

### Requirements
In order to build and run the framework, you should have `docker` installed on your system.

The project is tested on `Mac OS Ventura 13.6 (22G120)` and `Docker version 20.10.23, build 7155243`.

The docker image is based on `Ubuntu Jammy 22.04`.

### Supported Architectures
The framework supports only `amd64` architecture. Will be supported other architectures in the future.

### Build
To build the framework, you should run the following command in the root directory of the project:
```bash
./docker.sh -v ./build.sh --build-dir build_amd64 --build-type Release
```

The framework will be built in `build_amd64` directory, and automatically installed in `/usr/lib` directory in the docker container.

If you have the same architecture with `amd64` and platform `Ubuntu Jammy`, you can install the framework on your system by running the following command in the root directory of the project after building the framework:

```bash
./build.sh --build-dir build_amd64 --only-install
```


### Run Tests
To run tests, you should run the following command in the root directory of the project:
```bash
./docker.sh -v ./test.sh --build-dir test_build_amd64 --build-type Release --all-tests
```

Also, you can run only C++ unit tests or python bindings tests by running the following command in the root directory of the project.

C++ unit tests:
```bash
./docker.sh -v ./test.sh --build-dir test_build_amd64 --build-type Release --cpp-tests
```

Python bindings tests:
```bash
./docker.sh -v ./test.sh --build-dir test_build_amd64 --build-type Release --python-tests
```

## Help
For more information, you can run the following command in the root directory of the project:
```bash
./docker.sh --help
./build.sh --help
./test.sh --help
```

## License
[MIT](LICENSE)

## Author
[Sevki KOCADAG](mailto:bekirsevki@gmail.com)