require 'minitest/autorun'
require './lib/median_maintenance.rb'

class MedianTest < MiniTest::Test

	def test_very_small
		aFilename = "tests/case_files/TestCaseVerySmall.txt"
		result = MedianMaintenance.sumOfMediansFromFile(aFilename)
		assert result == 23, "Very small case failed. Expected 23 - Result: " + result.to_s
	end

	def test_small
		aFilename = "tests/case_files/TestCaseSmall.txt"
		result = MedianMaintenance.sumOfMediansFromFile(aFilename)
		assert result == 55, "Small case failed. Expected 55 - Result: " + result.to_s
	end

	def test_medium
		aFilename = "tests/case_files/TestCaseMedium.txt"
		result = MedianMaintenance.sumOfMediansFromFile(aFilename)
		assert result == 82, "Medium case failed. Expected 82 - Result: " + result.to_s
	end

	def test_large
		aFilename = "tests/case_files/TestCaseLarge.txt"
		result = MedianMaintenance.sumOfMediansFromFile(aFilename)
		assert result == 5819, "Large case failed. Expected 5819 - Result: " + result.to_s
	end
end
