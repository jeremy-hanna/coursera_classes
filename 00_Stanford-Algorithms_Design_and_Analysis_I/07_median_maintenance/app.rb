#!/usr/bin/env ruby

require './lib/median_maintenance.rb'

aFilename = "Median.txt"
puts MedianMaintenance.sumOfMediansFromFile(aFilename).to_s
