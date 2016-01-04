module TwoSumModule
	def self.twoSumFromFile(aFilename)
		aHash = Hash.new
		contents = File.readlines(aFilename)
		contents.each do |aLineFromFile|
			aLine = aLineFromFile.split
			x = aLine[0]
			if !aHash.has_key?(x)
				aHash[x] = x.to_i
			end
		end
		puts 'generated hash, beginning interval 2sum'
		 
		sum = 0
		(-10000).upto(10000) do |t|
			aHash.each_value do |x|
				y = t - x
				if y < x && aHash.has_key?(y.to_s)
					sum += 1
					break
				end
			end
		end

		return sum
	end
end
