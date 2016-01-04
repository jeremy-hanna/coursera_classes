require 'minitest/autorun'
require './lib/heap.rb'

class Fixnum
	def key
		return self
	end
end

class HeapTest < MiniTest::Test

	def test_fixnum_override
		assert 1.key == 1
	end

	def test_minimum_heap_basic_operations
		test_heap = HeapModule::MinHeap.new
		assert test_heap.extract.nil?, "Empty heap extract doesn't return nil."
		test_heap.insert(5)
		assert test_heap.peek == 5, "Heap size 1 incorrect peek value."
		assert test_heap.extract == 5, "Heap size 1 doesn't return a correct value."
		assert test_heap.extract.nil?, "Heap doesn't remove a node on extract."
		test_heap.insert(4)
		test_heap.insert(3)
		assert test_heap.extract == 3, "Heap size 2 doesn't return minimum value."
		assert test_heap.extract == 4, "Heap doesn't remove minimum node on extract."
		assert test_heap.extract.nil?, "Heap doesn't remove a node on extract."
	end

	def test_minimum_heap_batch_operations_and_delete
		test_heap = HeapModule::MinHeap.new
		test_heap.heapify([4,4,9,13,4,12,8,11,9])
		assert test_heap.heap_array == [nil,4,4,8,9,4,12,9,11,13], "Incorrect heap array after MinHeap.heapify\n" + test_heap.heap_array.to_s
		assert test_heap.deleteAt(2).key == 4, "Incorrect delete return value"
		assert test_heap.heap_array == [nil,4,4,8,9,13,12,9,11], "Incorrect heap array after delete operation\n" + test_heap.heap_array.to_s
		assert test_heap.deleteAt(3).key == 8, "Incorrect delete return value"
		assert test_heap.heap_array == [nil,4,4,9,9,13,12,11], "Incorrect heap array after delete operation\n" + test_heap.heap_array.to_s
	end

	def test_large_minimum_heap
		test_heap = HeapModule::MinHeap.new
		a = Array (3..90000)
		test_heap.heapify(a.shuffle)
		refute test_heap.heap_array == a, "Heap array is the same as starting array"
		assert test_heap.peek.key == 3, "Not minimum value from peek: expecting 3"
		assert test_heap.extract.key == 3, "Not minimum value from extract: expecting 3"
		assert test_heap.extract.key == 4, "Not minimum value from extract: expecting 4"
		assert test_heap.extract.key == 5, "Not minimum value from extract: expecting 5"
		assert test_heap.extract.key == 6, "Not minimum value from extract: expecting 6"
		assert test_heap.extract.key == 7, "Not minimum value from extract: expecting 7"
		assert test_heap.extract.key == 8, "Not minimum value from extract: expecting 8"
		assert test_heap.extract.key == 9, "Not minimum value from extract: expecting 9"
		assert test_heap.extract.key == 10, "Not minimum value from extract: expecting 10"
	end

	def test_maximum_heap_basic_operations
		test_heap = HeapModule::MaxHeap.new
		assert test_heap.extract.nil?, "Empty heap extract doesn't return nil."
		test_heap.insert(5)
		assert test_heap.peek == 5, "Heap size 1 incorrect peek value."
		assert test_heap.extract == 5, "Heap size 1 doesn't return a correct value."
		assert test_heap.extract.nil?, "Heap doesn't remove a node on extract."
		test_heap.insert(4)
		test_heap.insert(3)
		assert test_heap.extract == 4, "Heap size 2 doesn't return maximum value."
		assert test_heap.extract == 3, "Heap doesn't remove maximum node on extract."
		assert test_heap.extract.nil?, "Heap doesn't remove a node on extract."
	end

	def test_large_maximum_heap
		test_heap = HeapModule::MaxHeap.new
		a = Array (3..90000)
		test_heap.heapify(a.shuffle)
		refute test_heap.heap_array == a, "Heap array is the same as starting array"
		assert test_heap.peek.key == 90000, "Not maximum value from peek: expecting 90000"
		assert test_heap.extract.key == 90000, "Not maximum value from extract: expecting 90000"
		assert test_heap.extract.key == 89999, "Not maximum value from extract: expecting 89999"
		assert test_heap.extract.key == 89998, "Not maximum value from extract: expecting 89998"
		assert test_heap.extract.key == 89997, "Not maximum value from extract: expecting 89997"
		assert test_heap.extract.key == 89996, "Not maximum value from extract: expecting 89996"
		assert test_heap.extract.key == 89995, "Not maximum value from extract: expecting 89995"
		assert test_heap.extract.key == 89994, "Not maximum value from extract: expecting 89994"
		assert test_heap.extract.key == 89993, "Not maximum value from extract: expecting 89993"
	end
end
