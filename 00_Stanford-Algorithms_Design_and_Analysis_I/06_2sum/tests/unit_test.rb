require 'minitest/autorun'
require './lib/2sum.rb'

class SumTest < MiniTest::Test

	def test_duplicates
		aFilename = "tests/case_files/TestCaseDuplicate.txt"
		result = TwoSumModule.twoSumFromFile(aFilename)
		assert result == 11, "Duplicate case failed. Expected 11 - Result: " + result.to_s
	end

	def test_very_small
		aFilename = "tests/case_files/TestCaseVerySmall.txt"
		result = TwoSumModule.twoSumFromFile(aFilename)
		assert result == 3, "Very small case failed. Expected 3 - Result: " + result.to_s
	end

	def test_small
		aFilename = "tests/case_files/TestCaseSmall.txt"
		result = TwoSumModule.twoSumFromFile(aFilename)
		assert result == 5, "Small case failed. Expected 5 - Result: " + result.to_s
	end

	def test_medium
		aFilename = "tests/case_files/TestCaseMedium.txt"
		result = TwoSumModule.twoSumFromFile(aFilename)
		assert result == 6, "Medium case failed. Expected 6 - Result: " + result.to_s
	end

	def test_large
		aFilename = "tests/case_files/TestCaseLarge.txt"
#		result = TwoSumModule.twoSumFromFile(aFilename)
#		assert result == 20001, "Large case failed. Expected 20001 - Result: " + result.to_s
	end
end
