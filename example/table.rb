# VisualWidth::Table
require 'visual_width/table'
t = VisualWidth::Table.new(
  format: [VisualWidth::Table::LEFT, VisualWidth::Table::RIGHT, VisualWidth::Table::RIGHT]
)

header = ['Student', 'Mid-Terms', 'Finals']
rows = [
  ['アキラ', 94, 93],
  ['ケイ', 92, 99],
  ['Average', 93, 96],
]
puts t.render(rows, header: header)
