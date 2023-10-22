#include <algorithm>

#include "axelera_sort.h"

// QuickSort implementation
void AxeleraSort::quickSort(std::vector<int> &arr) {
    // Call the quick sort recursive function
    quickSortRecursive(arr, 0, arr.size() - 1);
}

void AxeleraSort::quickSortRecursive(std::vector<int> &arr, int low, int high) {
    if (low < high) {
        int pivot = partition(arr, low, high);
        quickSortRecursive(arr, low, pivot - 1);
        quickSortRecursive(arr, pivot + 1, high);
    }
}

int AxeleraSort::partition(std::vector<int> &arr, int low, int high) {
    // We choose the last element as the pivot
    // We then move all elements smaller than the pivot to the left of the pivot
    int pivot = arr[high];
    int i = (low - 1);
    for (int j = low; j <= high - 1; j++) {
        if (arr[j] < pivot) {
            // Move the smaller element to the left of the pivot
            i++;
            std::swap(arr[i], arr[j]);
        }
    }
    std::swap(arr[i + 1], arr[high]);
    return (i + 1);
}

// MergeSort implementation
void AxeleraSort::mergeSort(std::vector<int> &arr) {
    // Base case
    if (arr.size() <= 1) {
        return;
    }

    // Split the vector into two halves
    int mid = arr.size() / 2;
    std::vector<int> left(arr.begin(), arr.begin() + mid);
    std::vector<int> right(arr.begin() + mid, arr.end());

    // Recursively sort the two halves
    mergeSort(left);
    mergeSort(right);

    // Merge the two sorted halves
    std::vector<int>::size_type i = 0;
    std::vector<int>::size_type j = 0;
    std::vector<int>::size_type k = 0;
    while (i < left.size() && j < right.size()) {
        if (left[i] < right[j]) {
            arr[k++] = left[i++];
        } else {
            arr[k++] = right[j++];
        }
    }

    // Copy the remaining elements of left[], if there are any
    while (i < left.size()) {
        arr[k++] = left[i++];
    }

    // Copy the remaining elements of right[], if there are any
    while (j < right.size()) {
        arr[k++] = right[j++];
    }
}

// std::sort wrapper
void AxeleraSort::stdSort(std::vector<int> &arr) {
    // Call the std::sort function
    std::sort(arr.begin(), arr.end());
}

// BubbleSort implementation
void AxeleraSort::bubbleSort(std::vector<int> &arr) {
    // Iterate through the vector and swap adjacent elements if they are in the wrong order
    for (std::vector<int>::size_type i = 0; i < arr.size() - 1; i++) {
        for (std::vector<int>::size_type j = 0; j < arr.size() - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                std::swap(arr[j], arr[j + 1]);
            }
        }
    }
}
  
