# VisualWidth::Table
require 'visual_width/table'
t = VisualWidth::Table.new(
  style: [
    { align: :center, width:  8 },
    { align: :center, width:  8 },
    { align: :right,  width:  5 },
  ],
)

header = ['Nick', 'FullName', 'Age']
rows = [
  ['カネダ', '金田 正太郎', 17],
  ['テツオ', '島 鉄雄', 16],
  ['ケイ', '?', 18],
]
puts t.render(rows, header: header)
