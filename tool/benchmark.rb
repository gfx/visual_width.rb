#!/usr/bin/env ruby

require 'benchmark'
require 'visual_width'
require 'unicode/display_width'

str = "foo あいうえお bar αβγδε baz"

VisualWidth.measure(str) == str.display_width(2)

[str, str * 5, str * 10].each do |str|
  puts "\n", "measures string with length #{str.length}:"
  Benchmark.bmbm do |x|
    x.report("visual_width") do
      1000.times { VisualWidth.measure(str) }
    end
    x.report("display_width") do
      1000.times { str.display_width(2) }
    end
  end
end
