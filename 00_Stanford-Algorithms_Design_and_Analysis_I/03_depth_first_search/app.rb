#!/usr/bin/env ruby

require './lib/depth_first_search'

test_graph = GraphModule::Graph.createGraphFromFile('InputGraph.txt')
puts GraphModule.TopSCCsOf(test_graph)

