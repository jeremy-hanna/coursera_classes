#!/usr/bin/env ruby

require './lib/shortest_path.rb'

aFilename = "InputGraph.txt"
aGraph = GraphModule::Graph.createGraphFromFile(aFilename)
puts aGraph.findShortestPathFrom(1,7).to_s + "," + aGraph.findShortestPathFrom(1,37).to_s + "," + aGraph.findShortestPathFrom(1,59).to_s + "," + aGraph.findShortestPathFrom(1,82).to_s + "," + aGraph.findShortestPathFrom(1,99).to_s + "," + aGraph.findShortestPathFrom(1,115).to_s + "," + aGraph.findShortestPathFrom(1,133).to_s + "," + aGraph.findShortestPathFrom(1,165).to_s + "," + aGraph.findShortestPathFrom(1,188).to_s + "," + aGraph.findShortestPathFrom(1,197).to_s
