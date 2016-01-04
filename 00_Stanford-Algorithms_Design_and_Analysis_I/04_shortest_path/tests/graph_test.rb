require 'minitest/autorun'
require './lib/heap.rb'
require './lib/shortest_path.rb'

class WeightedDirectionalGraphTest < MiniTest::Test
	def test_graph_from_file_very_small
		aFileName = "tests/case_files/VerySmallCase.txt"
		test_graph = GraphModule::Graph.createGraphFromFile(aFileName)
		assert test_graph.vertexCount == 2, "Incorrect number of vertices created."
		assert test_graph.edgeCount == 1, "Incorrect number of edges created."
		assert test_graph.edges['1-2'].weight == 30, "Incorrect edge weight from file."
	end

	def test_graph_from_file_small
		aFileName = "tests/case_files/SmallTestCase1.txt"
		test_graph = GraphModule::Graph.createGraphFromFile(aFileName)
		assert test_graph.vertexCount == 4, "Incorrect number of vertices created."
		assert test_graph.edgeCount == 4, "Incorrect number of edges created."
	end

	def test_graph_from_file_medium
		aFileName = "tests/case_files/MediumTestCase.txt"
		test_graph = GraphModule::Graph.createGraphFromFile(aFileName)
		assert test_graph.vertexCount == 7, "Incorrect number of vertices created."
		assert test_graph.edgeCount == 12, "Incorrect number of edges created."
	end

	def test_graph_from_file_large
		aFileName = "tests/case_files/LargeTestCase.txt"
		test_graph = GraphModule::Graph.createGraphFromFile(aFileName)
		assert test_graph.vertexCount == 15, "Incorrect number of vertices created."
		assert test_graph.edgeCount == 75, "Incorrect number of edges created."
	end
	
	def test_graph_from_file_very_large
		aFileName = "tests/case_files/VeryLargeTestCase.txt"
		test_graph = GraphModule::Graph.createGraphFromFile(aFileName)
		assert test_graph.vertexCount == 50, "Incorrect number of vertices created."
	end
end
