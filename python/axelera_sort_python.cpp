
#include "pybind11/pybind11.h"
#include "pybind11/stl_bind.h"
#include "pybind11/stl.h"
#include "pybind11/functional.h"
#include "pybind11/operators.h"

#include <iostream>
#include <vector>

#include "axelera_sort.h"

namespace py = pybind11;


// Define a function to handle sorting and updating the Python list
// This function is called by each of the sorting functions
// It is defined here to avoid code duplication
/**
 * @brief Sorts a Python list and updates the list in-place.
 * 
 * @param self the AxeleraSort object
 * @param pyList the Python list to be sorted
 * @param functionName which sorting function to call
 */
void sortAndSetList(AxeleraSort& self, py::list& pyList, const std::string& functionName) {
    // Convert the Python list to a C++ vector
    std::vector<int> cppVector;
    for (auto item : pyList) {
        cppVector.push_back(py::cast<int>(item));
    }

    // Determine which sorting function to call based on the function name
    if (functionName == "quickSort") {
        self.quickSort(cppVector);
    } else if (functionName == "mergeSort") {
        self.mergeSort(cppVector);
    } else if (functionName == "stdSort") {
        self.stdSort(cppVector);
    } else if (functionName == "bubbleSort") {
        self.bubbleSort(cppVector);
    } else {
        throw std::runtime_error("Invalid sorting function name");
    }

    // Clear the Python list
    pyList.attr("clear")();

    // Convert the sorted C++ vector back to a Python list
    for (auto item : cppVector) {
        pyList.append(item);
    }
}

// Define the Python module
PYBIND11_MODULE(pyaxelera_framework, m) {
    // Define the module docstring
    m.doc() = "Python binding for Axelera Framework";

    // Define the AxeleraSort class
    py::class_<AxeleraSort>(m, "AxeleraSort")
        .def(py::init<>()) // Default constructor
        .def("quickSort", [](AxeleraSort& self, py::list& pyList) {
            sortAndSetList(self, pyList, "quickSort");
        }, "quick sort", py::arg("arr")) // QuickSort
        .def("mergeSort", [](AxeleraSort& self, py::list& pyList) {
            sortAndSetList(self, pyList, "mergeSort");
        }, "merge sort", py::arg("arr")) // MergeSort
        .def("stdSort", [](AxeleraSort& self, py::list& pyList) {
            sortAndSetList(self, pyList, "stdSort");
        }, "std sort", py::arg("arr")) // stdSort
        .def("bubbleSort", [](AxeleraSort& self, py::list& pyList) {
            sortAndSetList(self, pyList, "bubbleSort");
        }, "bubble sort", py::arg("arr")); // BubbleSort
}