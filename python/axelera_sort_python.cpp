#include <pybind11/pybind11.h>
#include <pybind11/stl.h>

#include "axelera_sort.h" 

namespace py = pybind11;

// Define the Python module
PYBIND11_MODULE(axelera_framework, m) {
    m.doc() = "Python binding for axelera_framework";
    py::class_<Sort>(m, "Sort")
        .def(py::init<>()) // Default constructor
        .def("quickSort", &Sort::quickSort) // quickSort function
        .def("mergeSort", &Sort::mergeSort) // mergeSort function
        .def("stdSort", &Sort::stdSort); // stdSort function
}