module GraphModule
  class Node
    attr_accessor(:in_edges, :out_edges, :label, :explored, :finishing_time)

    def initialize(aVertexLabel)
      self.label = aVertexLabel
      self.explored = false
      self.in_edges = Array.new
      self.out_edges = Array.new
      self.finishing_time = 0
    end

    def addEdgeConnectingTo(aNode)
      aNewEdge = Edge.initialize_connecting(self, aNode)
      self.out_edges.push aNewEdge
      return aNewEdge
    end

    def isExplored?
      return self.explored
    end

    def printConnections
      outputString = "Vertex: " + self.label + " - is connected to: "
      self.edges.each do |e|
        outputString += e.connecting(self).label + " "
      end
      puts outputString
    end
    
    def degree
      return edges.length
    end
  end
  
  class Edge # ? do I need to track edges as its own class ?
    attr_accessor(:head, :tail)

    def self.initialize_connecting(aHeadNode, aTailNode)
      aNewEdge = Edge.new
      aNewEdge.head = aHeadNode
      aNewEdge.tail = aTailNode
      aNewEdge.tail.in_edges.push(aNewEdge)
      return aNewEdge
    end

    def connecting(aNode)
      return self.head == aNode ? self.tail : self.head
    end
  end

  class Graph
    attr_accessor(:vertices, :edges)

    def self.createGraphFromFile(aFilename)
      initializedGraph = Graph.new
      contents = File.readlines(aFilename)
      contents.each do |aLineOfInput|
	parsedInput = aLineOfInput.split
	if initializedGraph.vertices[parsedInput[0].to_i].nil?
		initializedGraph.vertices[parsedInput[0].to_i] = Node.new parsedInput[0]
	end

	if initializedGraph.vertices[parsedInput[1].to_i].nil?
		initializedGraph.vertices[parsedInput[1].to_i] = Node.new parsedInput[1]
	end

	initializedGraph.edges.push initializedGraph.vertices[parsedInput[0].to_i].addEdgeConnectingTo(initializedGraph.vertices[parsedInput[1].to_i])
      end
      return initializedGraph
    end

    def initialize
      self.vertices = Array.new
      self.edges = Array.new
    end

    def printCounts
      return 'Vertices: ' + self.vertices.length.to_s + '. Edges: ' + self.edges.length.to_s + '.'
    end

    def printVerticesArray
      self.vertices.to_s
      self.vertices.each do |aVertex|
        aVertex.printConnections 
      end
      $stdout.flush
    end

    def vertexCount
	    return self.vertices.length - 1
    end

    def edgeCount
	    return self.edges.length
    end
  end
end
