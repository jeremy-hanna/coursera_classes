require './lib/graphs.rb'

module GraphModule
	def self.DFS(aGraph, aStartingNode, aSCCcount)
		aStartingNode.explored = true
		aStack = Array.new.push aStartingNode
		while !aStack.empty?
			inspectedNode = aStack.last
			length = aStack.length

			inspectedNode.out_edges.each do |anOutgoingEdge|
				if !anOutgoingEdge.tail.isExplored?
					anOutgoingEdge.tail.explored = true
					aStack.push anOutgoingEdge.tail
				end
			end
			if length == aStack.length
				aStack.pop
				aSCCcount += 1
			end
		end
		#		aSCCcount = self.DFS(aGraph, anOutgoingEdge.tail, aSCCcount)
		#	end
		#end
		return aSCCcount
	end

	def self.DFS_loop(aGraph)
		#on leader increment, compare count of that leader to top 5 SCC counts
		top_five_SCC_counts = Array.new(5, 0)

		source_node = nil

		aGraph.vertexCount.downto(1) do |i|
			scc_count = 0
			if !aGraph.vertices[i].isExplored?
				source_node = aGraph.vertices[i]
				scc_count = self.DFS(aGraph, aGraph.vertices[i], scc_count)
			end

			#if the count is in the top 5, add it to return array
			j = 0
			while j < 5 && scc_count > top_five_SCC_counts[j]
				j += 1
			end
			if j > 0
				top_five_SCC_counts.insert(j, scc_count)
				top_five_SCC_counts.shift
			end
		end

		return top_five_SCC_counts
	end
	
	def self.DFS_reverse(aGraph, aStartingNode, currentTimer)
		aStack = Array.new
		aStack.push aStartingNode
		while !aStack.empty?
			if aStack.last.isExplored?
				inspectedNode = aStack.pop
				if inspectedNode.finishing_time == 0
					currentTimer += 1
					inspectedNode.finishing_time = currentTimer
					#puts "\nSet node: " + inspectedNode.label + " - f(v) to: " + currentTimer.to_s
				end
			else
				inspectedNode = aStack.last
				inspectedNode.explored = true
			
				inspectedNode.in_edges.each do |anIncomingEdge|
					if !anIncomingEdge.head.isExplored?
						aStack.push anIncomingEdge.head
					end
				end
		#aStartingNode.in_edges.each do |anIncomingEdge|
		#	if !anIncomingEdge.head.isExplored?
		#		currentTimer = self.DFS_reverse(aGraph, anIncomingEdge.head, currentTimer)
			end
		end
		return currentTimer
	end

	def self.DFS_reverse_loop(aGraph)
		timer = 0
		aGraph.vertexCount.downto(1) do |i|
			if !aGraph.vertices[i].isExplored?
				timer = self.DFS_reverse(aGraph, aGraph.vertices[i], timer)
			end
		end

		#move vertices to position based on f(v)
		newlyOrderedVerticeArray = Array.new(aGraph.vertexCount + 1)
		aGraph.vertexCount.downto(1) do |i|
			aGraph.vertices[i].explored = false
			newlyOrderedVerticeArray[aGraph.vertices[i].finishing_time] = aGraph.vertices[i]
		end
		aGraph.vertices = newlyOrderedVerticeArray
	end

	def self.TopSCCsOf(aGraph)
		self.DFS_reverse_loop(aGraph)
		top_five = self.DFS_loop(aGraph)
		output_string = ""
		top_five.reverse.each { |i| output_string += i.to_s + ',' }
		return output_string.chop
	end
end

