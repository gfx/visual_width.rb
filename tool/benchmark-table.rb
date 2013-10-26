#!/usr/bin/env ruby

require 'benchmark'
require 'visual_width/table'
require 'terminal-table'
require 'text-table'

header = [:Name, :Arity?, :DefinedInTheClass?]

rows = String.instance_methods.map do |sym|
  [sym, "".method(sym).arity, "".class.superclass.instance_methods.include?(sym)]
end

tabler = VisualWidth::Table.new(
  header: header,
)

a = tabler.render(rows)
b = Terminal::Table.new(rows: rows, headings: header)
c = Text::Table.new(head: header, rows: rows)

Benchmark.bmbm do |x|
  x.report("visual_width/table") do
    100.times { tabler.render(rows) }
  end
  x.report("terminal-table") do
    100.times { Terminal::Table.new(rows: rows, headings: header).to_s }
  end
  x.report("text-table") do
    100.times { Text::Table.new(rows: rows, head: header).to_s }
  end
end
