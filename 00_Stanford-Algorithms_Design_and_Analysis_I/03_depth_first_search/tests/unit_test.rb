require 'minitest/autorun'
require './lib/depth_first_search.rb'

class GraphTest < MiniTest::Test
	def test_if_generates_from_file
		test_graph = GraphModule::Graph.createGraphFromFile('tests/case_files/2V1Egraph.txt')
		assert test_graph.vertexCount == 2, "Incorrect # of vertices"
	        assert test_graph.edgeCount == 1, "Incorrect # of edges"
		assert test_graph.edges[0].head.label == '1', "Incorrect edge.head"
		assert test_graph.edges[0].tail.label == '2', "Incorrect edge.tail" 
	end

	def test_if_case_two_is_correctly_generated
		test_graph = GraphModule::Graph.createGraphFromFile('tests/case_files/TestCase1.txt')
		assert test_graph.vertexCount == 9, "Incorrect # of vertices"
	        assert test_graph.edgeCount == 11, "Incorrect # of edges"
	end

	def test_if_case_three_is_correctly_generated
		test_graph = GraphModule::Graph.createGraphFromFile('tests/case_files/TestCase2.txt')
		assert test_graph.vertexCount == 8, "Incorrect # of vertices"
	        assert test_graph.edgeCount == 14, "Incorrect # of edges"
	end
	
	def test_if_case_three_is_correctly_generated
		test_graph = GraphModule::Graph.createGraphFromFile('tests/case_files/TestCase3.txt')
		assert test_graph.vertexCount == 15, "Incorrect # of vertices"
	        assert test_graph.edgeCount == 18, "Incorrect # of edges"
	end

	def test_if_case_large_is_correctly_generated
		test_graph = GraphModule::Graph.createGraphFromFile('tests/case_files/TestCaseLarge.txt')
		assert test_graph.vertexCount == 10000, "Incorrect # of vertices"
	end

	#test DFS behavior
	def test_DFS_behavior
		test_graph = GraphModule::Graph.createGraphFromFile('tests/case_files/TestCase3.txt')
		refute test_graph.vertices[15].isExplored?
		assert GraphModule.DFS(test_graph, test_graph.vertices[15], 0) == 1, "SCC count is wrong"
		assert test_graph.vertices[15].isExplored?
		assert GraphModule.DFS(test_graph, test_graph.vertices[10], 0) == 5, "SCC count of second DFS was wrong"
		refute test_graph.vertices[2].isExplored?
		assert test_graph.vertices[12].isExplored?
		assert test_graph.vertices[14].isExplored?
		refute test_graph.vertices[5].isExplored?
		refute test_graph.vertices[1].isExplored?
		assert GraphModule.DFS(test_graph, test_graph.vertices[1], 0) == 9, "SCC count of third DFS was wrong"
		assert test_graph.vertices[9].isExplored?
		assert test_graph.vertices[4].isExplored?
	end
	
	#test edge reverse behavior
	def test_DFS_reverse_loop_behavior
		test_graph = GraphModule::Graph.createGraphFromFile('tests/case_files/TestCase3.txt')
		GraphModule.DFS_reverse_loop(test_graph)
		assert ['15'].include?(test_graph.vertices[15].label), "15 failed"
		assert ['7','8','9','6'].include?(test_graph.vertices[12].label), "12 failed"
	end
end
