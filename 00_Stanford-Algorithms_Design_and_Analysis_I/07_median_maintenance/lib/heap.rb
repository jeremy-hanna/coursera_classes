module HeapModule
	class MinHeap
		attr_accessor(:heap_array, :size)

		def initialize
			self.heap_array = [nil]
			self.size = 0
		end

		def swap(firstIndex, secondIndex)
			temp = self.heap_array[firstIndex]
			self.heap_array[firstIndex] = self.heap_array[secondIndex]
			self.heap_array[secondIndex] = temp
			self.heap_array[firstIndex].heap_index = firstIndex unless self.heap_array[firstIndex].frozen?
			self.heap_array[secondIndex].heap_index = secondIndex unless self.heap_array[secondIndex].frozen?
		end

		def heapify(aBatchArray)
			self.heap_array = self.heap_array + aBatchArray
			#bubbleDown each subtree root starting at the leaves
			self.size = self.heap_array.length - 1
			self.size.downto(1) do |i|
				self.heap_array[i].heap_index = i unless self.heap_array[i].frozen?
				self.bubbleDown(i)
			end
		end

		def peek
			return self.heap_array[1]
		end

		def parentIndexOf(anIndex)
			return anIndex >> 1
		end

		def leftChildIndexOf(anIndex)
			childIndex = anIndex << 1
			if childIndex <= self.size
				return childIndex
			end
			return nil
		end

		def rightChildIndexOf(anIndex)
			childIndex = (anIndex << 1) + 1
			if childIndex <= self.size
				return childIndex
			end
			return nil
		end

		def insert(anObject)
			self.heap_array.push anObject
			self.size += 1
			anObject.heap_index = self.size unless anObject.frozen?
			return self.bubbleUp(self.size)
		end

		def extract
			if size > 0
				return self.deleteAt(1)
			end
			return nil
		end

		def deleteAt(anIndex)
			self.swap(anIndex, self.size)
			self.size -= 1
			returnObject = self.heap_array.pop
			returnObject.heap_index = 0 unless returnObject.frozen?
			parentIndex = self.parentIndexOf(anIndex)
			if parentIndex > 0 && anIndex <= self.size && self.heap_array[parentIndex].key > self.heap_array[anIndex].key
				self.bubbleUp(anIndex)
			else
				self.bubbleDown(anIndex)
			end
			return returnObject
		end

		def bubbleUp(anIndex)
			while anIndex > 1 do
				parentIndex = self.parentIndexOf(anIndex)
				parent = self.heap_array[parentIndex]
				if !parent.nil? && parent.key > self.heap_array[anIndex].key
					self.swap(anIndex, parentIndex)
					anIndex = parentIndex
				else
					anIndex = 1
				end
			end
		end

		def bubbleDown(anIndex)
			while anIndex <= self.parentIndexOf(self.size)
				leftChildIndex = self.leftChildIndexOf(anIndex)
				rightChildIndex = self.rightChildIndexOf(anIndex)
				if rightChildIndex.nil?
					smallestChildIndex = leftChildIndex
				else
					smallestChildIndex = (self.heap_array[leftChildIndex].key < self.heap_array[rightChildIndex].key) ? leftChildIndex : rightChildIndex
				end
				if self.heap_array[anIndex].key > self.heap_array[smallestChildIndex].key
					self.swap(anIndex, smallestChildIndex)
					anIndex = smallestChildIndex
				else
					anIndex = self.size
				end
			end
		end
	end

	class MaxHeap
		attr_accessor(:heap_array, :size)

		def initialize
			self.heap_array = [nil]
			self.size = 0
		end

		def swap(firstIndex, secondIndex)
			temp = self.heap_array[firstIndex]
			self.heap_array[firstIndex] = self.heap_array[secondIndex]
			self.heap_array[secondIndex] = temp
			self.heap_array[firstIndex].heap_index = firstIndex unless self.heap_array[firstIndex].frozen?
			self.heap_array[secondIndex].heap_index = secondIndex unless self.heap_array[secondIndex].frozen?
		end

		def heapify(aBatchArray)
			self.heap_array = self.heap_array + aBatchArray
			#bubbleDown each subtree root starting at the leaves
			self.size = self.heap_array.length - 1
			self.size.downto(1) do |i|
				self.heap_array[i].heap_index = i unless self.heap_array[i].frozen?
				self.bubbleDown(i)
			end
		end

		def peek
			value = 0
			value += self.heap_array[1].key
			return value
		end

		def parentIndexOf(anIndex)
			return anIndex >> 1
		end

		def leftChildIndexOf(anIndex)
			childIndex = anIndex << 1
			if childIndex <= self.size
				return childIndex
			end
			return nil
		end

		def rightChildIndexOf(anIndex)
			childIndex = (anIndex << 1) + 1
			if childIndex <= self.size
				return childIndex
			end
			return nil
		end

		def insert(anObject)
			self.heap_array.push anObject
			self.size += 1
			anObject.heap_index = self.size unless anObject.frozen?
			return self.bubbleUp(self.size)
		end

		def extract
			if size > 0
				return self.deleteAt(1)
			end
			return nil
		end

		def deleteAt(anIndex)
			self.swap(anIndex, self.size)
			self.size -= 1
			returnObject = self.heap_array.pop
			returnObject.heap_index = 0 unless returnObject.frozen?
			parentIndex = self.parentIndexOf(anIndex)
			if parentIndex > 0 && anIndex <= self.size && self.heap_array[parentIndex].key < self.heap_array[anIndex].key
				self.bubbleUp(anIndex)
			else
				self.bubbleDown(anIndex)
			end
			return returnObject
		end

		def bubbleUp(anIndex)
			while anIndex > 1 do
				parentIndex = self.parentIndexOf(anIndex)
				parent = self.heap_array[parentIndex]
				if !parent.nil? && parent.key < self.heap_array[anIndex].key
					self.swap(anIndex, parentIndex)
					anIndex = parentIndex
				else
					anIndex = 1
				end
			end
		end

		def bubbleDown(anIndex)
			while anIndex <= self.parentIndexOf(self.size)
				leftChildIndex = self.leftChildIndexOf(anIndex)
				rightChildIndex = self.rightChildIndexOf(anIndex)
				if rightChildIndex.nil?
					largestChildIndex = leftChildIndex
				else
					largestChildIndex = (self.heap_array[leftChildIndex].key > self.heap_array[rightChildIndex].key) ? leftChildIndex : rightChildIndex
				end
				if self.heap_array[anIndex].key < self.heap_array[largestChildIndex].key
					self.swap(anIndex, largestChildIndex)
					anIndex = largestChildIndex
				else
					anIndex = self.size
				end
			end
		end
	end
end
