module GraphModule
  class Node
    attr_accessor(:edges, :label)

    def initialize(aVertexLabel)
      self.label = aVertexLabel
      self.edges = Array.new
    end

    def addEdgeConnectingTo(aNode)
      aNewEdge = Edge.initialize_connecting(self, aNode)
      self.edges.push aNewEdge
      return aNewEdge
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
      aNewEdge.tail.edges.push(aNewEdge)
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
	initializedGraph.vertices[parsedInput[0].to_i] = Node.new(parsedInput[0])
	parsedInput.each do |aVertexLabel|
          if aVertexLabel.to_i < parsedInput[0].to_i
            initializedGraph.edges.push initializedGraph.vertices[aVertexLabel.to_i].addEdgeConnectingTo(initializedGraph.vertices[parsedInput[0].to_i])
	  end
	end
      end
      initializedGraph.vertices.shift
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
  end
end
