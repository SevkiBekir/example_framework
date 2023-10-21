#ifndef AXELERA_SORT_H
#define AXELERA_SORT_H

#include <vector>

/**
 * @class Sort
 * @brief A class that provides various sorting algorithms.
 */
class Sort {
public:

    /**
     * @brief Default constructor.
     */
    Sort() = default;

    /**
     * @brief Deleted copy constructor.
     */
    Sort(const Sort&) = delete;

    /**
     * @brief Deleted copy assignment operator.
     */
    Sort& operator=(const Sort&) = delete;

    /**
     * @brief Deleted move constructor.
     */
    Sort(Sort&&) = delete;

    /**
     * @brief Deleted move assignment operator.
     */
    Sort& operator=(Sort&&) = delete;

    /**
     * @brief Default destructor.
     */
    virtual ~Sort() = default;


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
