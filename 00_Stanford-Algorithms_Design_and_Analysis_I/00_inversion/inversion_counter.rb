#!/usr/bin/env ruby

class Array
    def countInversionsAndSort!
      totalInversions = 0
      if self.length > 1
        rightArray = self.slice(self.length / 2..self.length-1)
        leftArray = self.slice(0..self.length/2-1)
        totalInversions += leftArray.countInversionsAndSort! + rightArray.countInversionsAndSort! + self.mergeAndCountSplitsWith!(leftArray, rightArray)
      end
      return totalInversions
    end

    def mergeAndCountSplitsWith!(leftArray, rightArray)
      i, j, k, inversionCount = 0, 0, 0, 0

      while k < self.length
        if i == leftArray.length
          self[k] = rightArray[j]
          j += 1
        elsif j == rightArray.length
          self[k] = leftArray[i]
          i += 1
        elsif leftArray[i] <= rightArray[j]
          self[k] = leftArray[i]
          i += 1
        else
          self[k] = rightArray[j]
          j += 1
          inversionCount += leftArray.length - i
        end
        k += 1
      end
      return inversionCount
    end
  end

aFileName = "IntegerArray.txt"
intArrayFromFile = File.readlines(aFileName)
intArrayFromFile.map! {|x| x.chomp.to_i}

#anArray = [1,3,5,7,2,4,6,8]
puts intArrayFromFile.countInversionsAndSort! 
#output = ''
#anArray.each {|x| output += x.to_s} 
#puts output
