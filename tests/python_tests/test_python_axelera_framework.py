#!/usr/bin/python3
import sys
import time
import unittest

import pyaxelera_framework as axelera_fw

class TestAxeleraFrameworkSort(unittest.TestCase):
    '''
        Test Axelera Framework Quick Sort
    '''
    def setUp(self) -> None:
        self._axelera_framework = axelera_fw.Sort()
        return super().setUp()
    
    def tearDown(self) -> None:
        return super().tearDown()

    def test_quick_sort(self):
        arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
        self._axelera_framework.quickSort(arr)
        self.assertEqual(arr, [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9])
    
    def test_merge_sort(self):
        arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
        self._axelera_framework.mergeSort(arr)
        self.assertEqual(arr, [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9])
        
    def test_std_sort(self):
        arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
        self._axelera_framework.stdSort(arr)
        self.assertEqual(arr, [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9])
            
        
if __name__ == '__main__':
    unittest.main()
