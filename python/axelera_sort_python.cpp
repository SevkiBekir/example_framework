
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
void sortAndSetList(Sort& self, py::list& pyList, const std::string& functionName) {
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

PYBIND11_MODULE(pyaxelera_framework, m) {
    m.doc() = "Python binding for axelera_framework";
    py::class_<Sort>(m, "Sort")
        .def(py::init<>()) // Default constructor
        .def("quickSort", [](Sort& self, py::list& pyList) {
            sortAndSetList(self, pyList, "quickSort");
        }, "quick sort", py::arg("arr"))
        .def("mergeSort", [](Sort& self, py::list& pyList) {
            sortAndSetList(self, pyList, "mergeSort");
        }, "merge sort", py::arg("arr"))
        .def("stdSort", [](Sort& self, py::list& pyList) {
            sortAndSetList(self, pyList, "stdSort");
        }, "std sort", py::arg("arr"))
        .def("bubbleSort", [](Sort& self, py::list& pyList) {
            sortAndSetList(self, pyList, "bubbleSort");
        }, "bubble sort", py::arg("arr"));
}