#include <algorithm>

#include "axelera_sort.h"

// QuickSort implementation
void Sort::quickSort(std::vector<int> &arr) {
    quickSortRecursive(arr, 0, arr.size() - 1);
}

void Sort::quickSortRecursive(std::vector<int> &arr, int low, int high) {
    if (low < high) {
        int pivot = partition(arr, low, high);
        quickSortRecursive(arr, low, pivot - 1);
        quickSortRecursive(arr, pivot + 1, high);
    }
}

int Sort::partition(std::vector<int> &arr, int low, int high) {
    int pivot = arr[high];
    int i = (low - 1);
    for (int j = low; j <= high - 1; j++) {
        if (arr[j] < pivot) {
            i++;
            std::swap(arr[i], arr[j]);
        }
    }
    std::swap(arr[i + 1], arr[high]);
    return (i + 1);
}

// MergeSort implementation
void Sort::mergeSort(std::vector<int> &arr) {
    if (arr.size() <= 1) {
        return;
    }

    int mid = arr.size() / 2;
    std::vector<int> left(arr.begin(), arr.begin() + mid);
    std::vector<int> right(arr.begin() + mid, arr.end());

    mergeSort(left);
    mergeSort(right);

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

    while (i < left.size()) {
        arr[k++] = left[i++];
    }

    while (j < right.size()) {
        arr[k++] = right[j++];
    }
}

// std::sort wrapper
void Sort::stdSort(std::vector<int> &arr) {
        std::sort(arr.begin(), arr.end());
}

// BubbleSort implementation
void Sort::bubbleSort(std::vector<int> &arr) {
    for (std::vector<int>::size_type i = 0; i < arr.size() - 1; i++) {
        for (std::vector<int>::size_type j = 0; j < arr.size() - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                std::swap(arr[j], arr[j + 1]);
            }
        }
    }
}
  
