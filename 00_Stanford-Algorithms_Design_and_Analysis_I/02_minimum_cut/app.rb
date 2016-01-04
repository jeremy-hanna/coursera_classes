#!/usr/bin/env ruby

require './lib/min_cut'

puts GraphModule.runMultipleMinCutsOnFile('InputGraph.txt', 10000)
#aGraph = GraphModule::Graph.createGraphFromFile('RTestCase1.txt')
#puts aGraph.printCounts
#puts aGraph.printVerticesArray
