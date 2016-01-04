require 'minitest/autorun'
require './lib/heap.rb'
require './lib/shortest_path.rb'


class ShortestPathTest < MiniTest::Test
	def test_heapify_graph_vertices
		aFileName = "tests/case_files/VerySmallCase.txt"
		test_graph = GraphModule::Graph.createGraphFromFile(aFileName)
		assert test_graph.vertexCount == 2, "Incorrect number of vertices created."
		assert test_graph.edgeCount == 1, "Incorrect number of edges created."
		assert test_graph.edges['1-2'].weight == 30, "Incorrect edge weight from file."
		test_heap = HeapModule::MinHeap.new
		test_heap.insert(1)
		assert test_heap.extract == 1, "Heap does not work"
		test_heap.heapify(test_graph.vertices)
		assert test_heap.heap_array.length == 3, "Heapify does not add all vertices"
		result = test_graph.findShortestPathFrom(1, 2)
		assert result == 30, "Shortest Path not working. Expected: 30, result: " + result.to_s
	end

	def test_shortest_from_file_small
		aFileName = "tests/case_files/SmallTestCase1.txt"
		test_graph = GraphModule::Graph.createGraphFromFile(aFileName)
		assert test_graph.vertexCount == 4, "Incorrect number of vertices created."
		assert test_graph.edgeCount == 4, "Incorrect number of edges created."
		result = test_graph.findShortestPathFrom(1, 4) 
		assert result == 2, "Incorrect path cost. Expected: 2, result: " + result.to_s
	end

	def test_shortest_from_file_medium
		aFileName = "tests/case_files/MediumTestCase.txt"
		test_graph = GraphModule::Graph.createGraphFromFile(aFileName)
		assert test_graph.vertexCount == 7, "Incorrect number of vertices created."
		assert test_graph.edgeCount == 12, "Incorrect number of edges created."
		result = test_graph.findShortestPathFrom(1, 7) 
		assert result == 5, "Incorrect path cost. Expected: 5, result: " + result.to_s
	end

	def test_shortest_from_file_large
		aFileName = "tests/case_files/LargeTestCase.txt"
		test_graph = GraphModule::Graph.createGraphFromFile(aFileName)
		assert test_graph.vertexCount == 15, "Incorrect number of vertices created."
		assert test_graph.edgeCount == 75, "Incorrect number of edges created."
		result = test_graph.findShortestPathFrom(13, 5)
	       	assert result == 26, "Incorrect path cost. Expected: 26, result:" + result.to_s
	end
	
	def test_shortest_from_file_very_large
		aFileName = "tests/case_files/VeryLargeTestCase.txt"
		test_graph = GraphModule::Graph.createGraphFromFile(aFileName)
		assert test_graph.vertexCount == 50, "Incorrect number of vertices created."
		result = test_graph.findShortestPathFrom(28, 6) 
		assert result == 9, "Incorrect path cost. Expected: 9, result: " + result.to_s
	end
end	
