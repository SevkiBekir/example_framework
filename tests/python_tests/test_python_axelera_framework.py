#!/usr/bin/python3
import sys
import time
import unittest
import random
import time
import copy

import pyaxelera_framework as axelera_fw

class TestAxeleraFrameworkSort(unittest.TestCase):
    '''
        Test Axelera Framework Quick Sort
    '''
    def setUp(self) -> None:
        self._axelera_framework = axelera_fw.Sort()
        self.init_test_setup()
        
        return super().setUp()
    
    def tearDown(self) -> None:
        return super().tearDown()
    
    def init_test_setup(self) -> None:
        self._small_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
        self._long_list = [5264, 784, 2013, 9456, 6331, 2314, 8490, 7262, 1175, 379, 4521, 1563, 9077, 
               7593, 4145, 4977, 2487, 5184, 9403, 4729, 8627, 5856, 8952, 4995, 7228, 7069, 
               864, 9549, 5716, 7432, 7725, 2927, 7731, 5635, 1507, 8912, 9982, 1416, 2673, 
               7582, 8062, 5099, 9803, 5127, 835, 669, 9612, 9421, 3322, 4822, 6115, 7038, 
               6664, 1291, 8663, 9848, 6597, 7714, 9362, 4635, 1808, 2994, 6026, 371, 8122, 
               2327, 8877, 2512, 975, 7568, 1975, 3084, 6839, 8672, 511, 2169, 8114, 8236, 
               5222, 6313, 3438, 4977, 6871, 7829, 2293, 1834, 4003, 1041, 8776, 6714, 8987, 
               3282, 606, 9876, 9794, 8803, 6903, 6226, 4889, 1267, 215, 3479, 6365, 1429, 
               5807, 7816, 1392, 8504, 8193, 8536, 1202, 9547, 3733, 8888, 8660, 5664, 2479, 
               3229, 220, 9311, 741, 8314, 7382, 9797, 4378, 432, 8362, 7267, 7597, 843, 7205, 
               1623, 9542, 2164, 4231, 1291, 3875, 2465, 4718, 7776, 255, 913, 7124, 729, 6143, 
               7821, 7424, 9119, 7042, 1371, 3635, 5519, 4215, 1215, 5822, 4153, 9004, 9502, 5808, 
               9365, 7236, 3843, 3667, 1362, 1892, 341, 7658, 8424, 8925, 2621, 7739, 2915, 4784, 
               5186, 1471, 890, 6423, 9642, 7174, 2682, 1505, 8607, 1319, 3319, 5092, 4993, 984, 
               7267, 6716, 9612, 4713, 880, 8789, 8746, 1411, 2442, 5354, 4557, 2684, 7382, 8319, 
               3844, 4976, 198, 3681, 4215, 1487, 7477, 4842, 4211, 8102, 4467, 3312, 7176, 7242, 
               7984, 5735, 1014, 1583, 9567, 5632, 1612, 4656, 9198, 9354, 1724, 3059, 788, 250, 
               8765, 9387, 1209, 2235, 8315, 636, 1834, 196, 6201, 9905, 1706, 4913, 2679, 9678, 
               4553, 7473, 7094, 320, 5061, 3665, 9833, 4568, 3189, 662, 896, 587, 3587, 797]
        
        self._random_numbers_list = [random.randint(1, 100000) for _ in range(100000)]
        
        # Sorted lists
        self._sorted_small_list = sorted(self._small_list)
        self._sorted_long_list = sorted(self._long_list)
        self._sorted_random_numbers_list = sorted(self._random_numbers_list)


    def test_quick_sort(self):
        print("\ntest_quick_sort")
        # Record the start time
        start = time.time()
        
        small_list = copy.deepcopy(self._small_list)
        self._axelera_framework.quickSort(small_list)
        self.assertEqual(small_list, self._sorted_small_list)
        end = time.time()
        
        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")
        
    def test_quick_sort_with_long_list(self):
        print("\ntest_quick_sort_with_long_list")
        # Record the start time
        start = time.time()
        
        long_list = copy.deepcopy(self._long_list)
        self._axelera_framework.quickSort(long_list)
        self.assertEqual(long_list, self._sorted_long_list)
        
        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")
        
    def test_quick_sort_with_random_list(self):
        print("\ntest_quick_sort_with_random_list")
        # Record the start time
        start = time.time()
        
        random_list = copy.deepcopy(self._random_numbers_list)
        self._axelera_framework.quickSort(random_list)
        self.assertEqual(random_list, self._sorted_random_numbers_list)
        
        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")

    
    def test_merge_sort(self):
        print("\ntest_merge_sort")
        # Record the start time
        start = time.time()
        
        
        small_list = copy.deepcopy(self._small_list)
        self._axelera_framework.mergeSort(small_list)
        self.assertEqual(small_list, self._sorted_small_list)
        
        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")
        
    def test_merge_sort_with_long_list(self):
        print("\ntest_merge_sort_with_long_list")
        # Record the start time
        start = time.time()

        long_list = copy.deepcopy(self._long_list)
        self._axelera_framework.mergeSort(long_list)
        self.assertEqual(long_list, self._sorted_long_list)
        
        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")
        
    def test_merge_sort_with_random_list(self):
        print("\ntest_merge_sort_with_random_list")
        # Record the start time
        start = time.time()
        
        
        random_list = copy.deepcopy(self._random_numbers_list)
        self._axelera_framework.mergeSort(random_list)
        self.assertEqual(random_list, self._sorted_random_numbers_list)
        
        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")
        
    def test_std_sort(self):
        print("\ntest_std_sort")
        # Record the start time
        start = time.time()
        
        
        small_list = copy.deepcopy(self._small_list)
        self._axelera_framework.stdSort(small_list)
        self.assertEqual(small_list, self._sorted_small_list)
        
        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")
        
    def test_std_sort_with_long_list(self):
        print("\ntest_std_sort_with_long_list")
        # Record the start time
        start = time.time()

        long_list = copy.deepcopy(self._long_list)
        self._axelera_framework.stdSort(long_list)
        self.assertEqual(long_list, self._sorted_long_list)
        
        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")
        
    def test_std_sort_with_random_list(self):
        print("\ntest_std_sort_with_random_list")
        # Record the start time
        start = time.time()
        
        random_list = copy.deepcopy(self._random_numbers_list)
        self._axelera_framework.stdSort(random_list)
        self.assertEqual(random_list, self._sorted_random_numbers_list)

        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")
        
    def test_bubble_sort(self):
        print("\ntest_bubble_sort")
        # Record the start time
        start = time.time()
        
        
        small_list = copy.deepcopy(self._small_list)
        self._axelera_framework.bubbleSort(small_list)
        self.assertEqual(small_list, self._sorted_small_list)
        
        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")
        
    def test_bubble_sort_with_long_list(self):
        print("\ntest_bubble_sort_with_long_list")
        # Record the start time
        start = time.time()

        long_list = copy.deepcopy(self._long_list)
        self._axelera_framework.bubbleSort(long_list)
        self.assertEqual(long_list, self._sorted_long_list)
        
        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")
        
    def test_bubble_sort_with_random_list(self):
        print("\ntest_bubble_sort_with_random_list")
        # Record the start time
        start = time.time()
        
        random_list = copy.deepcopy(self._random_numbers_list)
        self._axelera_framework.bubbleSort(random_list)
        self.assertEqual(random_list, self._sorted_random_numbers_list)

        # Record the end time
        end = time.time()

        # Calculate the time difference
        time_difference = end - start

        # Print the time difference in seconds
        print(f"Time taken: {time_difference:.6f} seconds")
            
        
if __name__ == '__main__':
    unittest.main()
