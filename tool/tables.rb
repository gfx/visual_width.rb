#!ruby
require 'terminal-table'
require 'text-table'
require 'visual_width/table'

table = Text::Table.new
table.head = ['じゃがいも', 'さといも']
table.rows = [['コロッケ', '雑煮']]
table.rows << ['肉じゃが', '塩ゆで']
puts table

rows = []
rows << ['じゃがいも', 'さといも']
rows << ['コロッケ', '雑煮']
rows << ['肉じゃが', '塩ゆで']
table = Terminal::Table.new :rows => rows
puts table

t = VisualWidth::Table.new

puts t.draw(rows)
