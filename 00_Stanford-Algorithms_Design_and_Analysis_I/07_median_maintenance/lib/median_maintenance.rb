require './lib/heap.rb'

module MedianMaintenance
	class ::NilClass
		def key
			return -1
		end
	end
	
	class ::Fixnum
		def key
			return self
		end
	end

	def self.sumOfMediansFromFile(aFilename)
		smallestHeap = HeapModule::MaxHeap.new
		largestHeap = HeapModule::MinHeap.new
		medianSum = 0

		content = File.readlines(aFilename)
		content.each do |aLineOfInput|
			aLine = aLineOfInput.split
			x = aLine[0].to_i
			if x < smallestHeap.peek
				smallestHeap.insert(x)
			else
				largestHeap.insert(x)
			end
			self.balanceHeaps(smallestHeap, largestHeap)
			medianSum += self.medianFromHeaps(smallestHeap, largestHeap)
		end
		return medianSum % 10000
	end

	def self.balanceHeaps(smallestHeap, largestHeap)
		if largestHeap.size > smallestHeap.size
			smallestHeap.insert largestHeap.extract
		elsif smallestHeap.size - largestHeap.size > 1
			largestHeap.insert smallestHeap.extract
		end
	end

	def self.medianFromHeaps(smallestHeap, largestHeap)
#		if smallestHeap.size.odd?
			return smallestHeap.peek
#		end
#		median = (smallestHeap.peek + largestHeap.peek) / 2.0
#		puts median.to_s
#		return median
	end
end

