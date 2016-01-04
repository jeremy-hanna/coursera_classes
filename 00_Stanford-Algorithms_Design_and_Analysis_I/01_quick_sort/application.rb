#!/usr/bin/env ruby

class Array
  def quicksortAndCount!(l, r)
    comparison_count = 0
    if r - l > 0
      median = (l + r) / 2
      #print "l: ", self[l].to_s, ", m: ", self[median].to_s, " r: ", self[r].to_s, "\n"
      if self[l] < self[r]
        if self[l] < self[median]
          if self[median] > self[r]
            self.swap!(r, l)
          else
            self.swap!(median, l) 
          end
        end
      else
        if self[r] > self[median]
          self.swap!(r, l)
        else
          if self[median] < self[l]
            self.swap!(median, l) 
          end
        end
      end
      #self.swap!(r, l) #swap last element to first position to use as a pivot
      pivot = self[l] #first element as pivot
      #puts pivot.to_s

      i = l + 1
      (l + 1).upto r do |j|
        if self[j] < pivot
          self.swap!(j, i)
          i += 1
        end
      end
      self.swap!(l, i -1)
      if i - 2 > l
        comparison_count += self.quicksortAndCount!(l, i - 2)
      end
      if r > i
        comparison_count += self.quicksortAndCount!(i, r)
      end
    end
    #puts (comparison_count + (r - l)).to_s
    return (comparison_count + (r - l))
  end

  def swap!(a, b)
    temp = self[a]
    self[a] = self[b]
    self[b] = temp
  end
end

class QuickSorter
  attr_accessor(:input_array) 

  def initialize(aFilename)
    if File.file?(aFilename)
      self.input_array = File.readlines(aFilename)
      self.input_array.map! {|x| x.chomp.to_i }
    end
  end

  def quicksortAndCount
    return self.input_array.quicksortAndCount!(0, self.input_array.length - 1)
  end
end

n = QuickSorter.new("IntegerArray.txt")

puts n.quicksortAndCount
i = 0
n.input_array.each do |x|
  i += 1
  if x != i
    puts "not sorted: expecting " + i.to_s + ", not " + x.to_s
  end
end
puts "done"
