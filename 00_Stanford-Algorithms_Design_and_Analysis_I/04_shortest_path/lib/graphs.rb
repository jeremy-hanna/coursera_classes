module GraphModule
  class Node
    attr_accessor(:edges, :label, :key, :heap_index)

    def initialize(aVertexLabel)
      self.label = aVertexLabel
      self.edges = Array.new
      self.key = 9999999
      self.heap_index = 0
    end

    def addEdgeConnectingTo(aNode, aWeight, anEdgeHashKey)
      aNewEdge = Edge.initialize_connecting(self, aNode, aWeight, anEdgeHashKey)
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
    attr_accessor(:head, :tail, :weight, :edge_hash_key)

    def self.initialize_connecting(aHeadNode, aTailNode, aWeight, anEdgeHashKey)
      aNewEdge = Edge.new
      aNewEdge.weight = aWeight
      aNewEdge.edge_hash_key = anEdgeHashKey
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
	headNode = parsedInput[0]
	if initializedGraph.vertices[headNode.to_i].nil?
		initializedGraph.vertices[headNode.to_i] = Node.new headNode
	end

	1.upto(parsedInput.length - 1) do |anIndex|
	  input_pair = parsedInput[anIndex].split(',')
	  if initializedGraph.vertices[input_pair[0].to_i].nil?
	    initializedGraph.vertices[input_pair[0].to_i] = Node.new input_pair[0]
	  end

	  edgeKey = (headNode.to_i < input_pair[0].to_i) ? headNode + "-" + input_pair[0] : input_pair[0] + "-" + headNode
	  if initializedGraph.edges[edgeKey].nil?
	    initializedGraph.edges[edgeKey] = initializedGraph.vertices[headNode.to_i].addEdgeConnectingTo(initializedGraph.vertices[input_pair[0].to_i], input_pair[1].to_i, edgeKey)
	  end
	end
      end

      initializedGraph.vertices.delete(nil)
      return initializedGraph
    end

    def initialize
      self.vertices = Array.new
      self.edges = Hash.new
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
	    return self.vertices.length 
    end

    def edgeCount
	    return self.edges.length
    end
  end
end
