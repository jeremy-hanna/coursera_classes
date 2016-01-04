require './lib/graphs.rb'
require './lib/heap.rb'

module GraphModule
	class Graph
		def findShortestPathFrom(aStartingNode, anEndNode)
			self.vertices.each do |aNode|
				aNode.key = 999999999
			end
			#Heap has all possible verticies
			#key is the greedy score to that vertex
			aHeap = HeapModule::MinHeap.new
			costArray = Array.new
			
			if self.vertices[0].label == '0'
				self.vertices[aStartingNode.to_i].key = 0
			else
				self.vertices[aStartingNode.to_i - 1].key = 0
			end
			
			aHeap.heapify(self.vertices)
			while costArray.length < self.vertices.length do
				greedyNode = aHeap.extract
				greedyNode.edges.each do |anEdge|
					connectedNode = anEdge.connecting(greedyNode)
					if connectedNode.heap_index > 0
						aHeap.deleteAt(connectedNode.heap_index)
						possibleNewKey = greedyNode.key + anEdge.weight
						if possibleNewKey < connectedNode.key
							connectedNode.key = possibleNewKey
						end
						aHeap.insert(connectedNode)
					end
				end
				costArray.push greedyNode
			end
			#add shortest
			#remove vertices to shortest
			#add vertices from shortest and aggregate

			if self.vertices[0].label == '0'
				return self.vertices[anEndNode.to_i].key
			else
				return self.vertices[anEndNode.to_i - 1].key
			end
		end
	end
end
