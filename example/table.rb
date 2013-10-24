# VisualWidth::Table
require 'visual_width/table'
t = VisualWidth::Table.new(
  format: [VisualWidth::Table::LEFT, VisualWidth::Table::RIGHT, VisualWidth::Table::RIGHT]
)

header = ['Student', 'Mid-Terms', 'Finals']
rows = [
  ['Sam', 94, 93],
  ['Jane', 92, 99],
  ['Average', 93, 96],
]
puts t.draw(rows, header: header)
