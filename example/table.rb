# VisualWidth::Table
require 'visual_width/table'
t = VisualWidth::Table.new(
  style: [
    { align: :center, width:  10 },
    { align: :center, width:  14 },
    { align: :left,   width:  28 },
  ],
  header: ['Title', 'Author', 'Beginning'],
)

# cf. http://www.benricho.org/famous_novel/
rows = [
  ['蜘蛛の糸', '芥川 龍之介', 'ある日の事でございます。 御釈迦様は極楽の 蓮池のふちを、独りでぶらぶら御歩きになっていらっしゃいました。'],
  ['こころ', '夏目 漱石', '私はその人を常に先生と呼んでいた。だからここでもただ先生と書くだけで本名は打ち明けない。'],
  ['人間失格', '太宰 治', '私は、その男の写真を三葉、見たことがある。']
]
puts t.render(rows)
