require './lib/graphs'

module GraphModule
  def self.runMultipleMinCutsOnFile(aFilename, numberOfIterations)
    aGraph = Graph.createGraphFromFile(aFilename)
    smallest_result = aGraph.vertices.length**2
    1.upto(numberOfIterations) do |x|
      result = aGraph.findMinimumCut
      puts 'Iteration : ' + x.to_s + '. Result: ' +result.to_s
      aGraph.reset
      if result < smallest_result && result > 0
	smallest_result = result
      end
    end
    return smallest_result
  end

  class Node
    attr_accessor(:parent)

    def initialize(aVertexLabel)
      self.label = aVertexLabel
      self.edges = Array.new
      self.parent = nil
    end
  end

  class ContractedNode
    attr_accessor(:children, :is_reset)

    def initialize
      self.children = Array.new
      self.is_reset = false
    end

    def addNode(aNode)
      self.children.push(aNode)
      aNode.parent = self
    end

    def combineContractedNodes(aContractedNode)
      if self.children.length <= aContractedNode.children.length
	aContractedNode.children.each do |aNode|
	  self.addNode(aNode)
	end
	return self
      else
	self.children.each do |aNode|
          aContractedNode.addNode(aNode)
	end
	return aContractedNode
      end
    end

    def nil?
      return self.is_reset
    end
  end

  class Edge
    def selfLoops?
      if self.head.parent.nil?
	return false
      elsif self.tail.parent.nil?
	return false
      end
      return self.head.parent == self.tail.parent
    end
  end
  
  class Graph
    attr_accessor(:working_array, :possible_edges)

    def initialize
      self.working_array = Array.new
      self.possible_edges = Array.new
      self.vertices = Array.new
      self.edges = Array.new
    end

    def reset
      self.working_array.each do |aContractedNode|
        if aContractedNode.is_a?(ContractedNode)
          aContractedNode.is_reset = true
	end
      end
      self.working_array.replace self.vertices
      self.possible_edges.replace self.edges
    end

    def findMinimumCut
      while self.working_array.length > 2 do
        self.contract(self.possible_edges[Random.rand(self.possible_edges.length)])
      end
      return self.possible_edges.length
    end

    def contract(anEdge)
      #Merge
      if anEdge.head.parent.nil?
        if anEdge.tail.parent.nil?
          self.working_array.reject! { |x| x == anEdge.tail || x == anEdge.head }
	  aContractedNode = ContractedNode.new
	  aContractedNode.addNode(anEdge.head).addNode(anEdge.tail)
	  self.working_array.push aContractedNode 
        else
          self.working_array.reject! { |x| x == anEdge.tail.parent || x == anEdge.head }
	  self.working_array.push anEdge.tail.parent.addNode(anEdge.head)
        end
      else
        if anEdge.tail.parent.nil?
          self.working_array.reject! { |x| x == anEdge.tail || x == anEdge.head.parent }
	  self.working_array.push anEdge.head.parent.addNode(anEdge.tail)
        else
          self.working_array.reject! { |x| x == anEdge.tail.parent || x == anEdge.head.parent }
	  self.working_array.push anEdge.tail.parent.combineContractedNodes(anEdge.head.parent)
        end
      end
      #Remove self loops
      self.possible_edges.reject! { |x| x.selfLoops? }
    end
  end
end
