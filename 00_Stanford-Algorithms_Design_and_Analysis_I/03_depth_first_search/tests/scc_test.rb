require 'minitest/autorun'
require './lib/depth_first_search.rb'

class StronglyConnectedComponentsTest < MiniTest::Test
	def test_if_case_one_is_correct
		test_graph = GraphModule::Graph.createGraphFromFile('tests/case_files/TestCase1.txt')
		result = GraphModule.TopSCCsOf(test_graph)
		assert result == "3,3,3,0,0", "#{result} is incorrect."
	end

	def test_if_case_two_is_correct
		test_graph = GraphModule::Graph.createGraphFromFile('tests/case_files/TestCase2.txt')
		result = GraphModule.TopSCCsOf(test_graph)
		assert result == "3,3,2,0,0", "#{result} is incorrect."
	end

	def test_if_case_three_is_correct
		test_graph = GraphModule::Graph.createGraphFromFile('tests/case_files/TestCase3.txt')
		result = GraphModule.TopSCCsOf(test_graph)
		assert result == "5,4,3,2,1", "#{result} is incorrect."
	end

	def test_if_case_large_is_correct
		test_graph = GraphModule::Graph.createGraphFromFile('tests/case_files/TestCaseLarge.txt')
		result = GraphModule.TopSCCsOf(test_graph)
		assert result == "7578,1996,1,1,1", "#{result} is incorrect."
	end
end
