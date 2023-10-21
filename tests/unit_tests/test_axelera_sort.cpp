#include "gtest/gtest.h"
#include "axelera_sort.h"

// Test fixture for sorting tests
class AxeleraSortTest : public ::testing::Test {
protected:
    void SetUp() override {
        // Set up any resources you need for the tests here.

    }

    void TearDown() override {
        // Clean up any resources used by the tests here.
    }

    AxeleraSort sorter; // create an object of the Axelera Sort class
};

TEST_F(AxeleraSortTest, QuickSortTest) {
    std::vector<int> arr = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5};
    sorter.quickSort(arr); // use the object to access the non-static member function
    ASSERT_EQ(arr, std::vector<int>({1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9}));
}


TEST_F(AxeleraSortTest, MergeSortTest) {
    std::vector<int> arr = {38, 27, 43, 3, 9, 82, 10};
    sorter.mergeSort(arr);
    ASSERT_EQ(arr, std::vector<int>({3, 9, 10, 27, 38, 43, 82}));
}

TEST_F(AxeleraSortTest, StdSortTest) {
    std::vector<int> arr = {17, 12, 56, 32, 8, 47};
    sorter.stdSort(arr);
    ASSERT_EQ(arr, std::vector<int>({8, 12, 17, 32, 47, 56}));
}

TEST_F(AxeleraSortTest, BubbleSortTest) {
    std::vector<int> arr = {17, 12, 56, 32, 8, 47};
    sorter.bubbleSort(arr);
    ASSERT_EQ(arr, std::vector<int>({8, 12, 17, 32, 47, 56}));
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}