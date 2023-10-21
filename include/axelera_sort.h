#ifndef AXELERA_SORT_H
#define AXELERA_SORT_H

#include <vector>

/**
 * @class AxeleraSort
 * @brief A class that provides various sorting algorithms for Axelera Framework.
 */
class AxeleraSort {
public:

    /**
     * @brief Default constructor.
     */
    AxeleraSort() = default;

    /**
     * @brief Deleted copy constructor.
     */
    AxeleraSort(const AxeleraSort&) = delete;

    /**
     * @brief Deleted copy assignment operator.
     */
    AxeleraSort& operator=(const AxeleraSort&) = delete;

    /**
     * @brief Deleted move constructor.
     */
    AxeleraSort(AxeleraSort&&) = delete;

    /**
     * @brief Deleted move assignment operator.
     */
    AxeleraSort& operator=(AxeleraSort&&) = delete;

    /**
     * @brief Default destructor.
     */
    virtual ~AxeleraSort() = default;


    /**
     * @brief Sorts a vector using the QuickSort algorithm.
     *
     * @param arr The vector to be sorted.
     */
    void quickSort(std::vector<int> &arr);

    /**
     * @brief Sorts a vector using the MergeSort algorithm.
     *
     * @param arr The vector to be sorted.
     */
    void mergeSort(std::vector<int> &arr);

    /**
     * @brief Sorts a vector using the std::sort algorithm (C++ Standard Library sort).
     *
     * @param arr The vector to be sorted.
     */
    void stdSort(std::vector<int> &arr);

    /**
     * @brief Sorts a vector using the BubbleSort algorithm.
     *
     * @param arr The vector to be sorted.
     */
    void bubbleSort(std::vector<int> &arr);

private:
    // Helper function for QuickSort
    void quickSortRecursive(std::vector<int> &arr, int low, int high);
    int partition(std::vector<int> &arr, int low, int high);
};


#endif //AXELERA_SORT_H
