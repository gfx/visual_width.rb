# coding: utf-8

require 'rspec'

require 'visual_width/table'

describe VisualWidth::Table do
  let (:rows) do
    rows = []
    rows << %w(りんご なし)
    rows << %w(べにしぐれ せいぎょく)
    rows << %w(となみ いなぎ)
    rows
  end

  context "#render" do
    it 'renders text table' do
      t = VisualWidth::Table.new

      expect(t.render(rows)).to eql(<<-'TEXT')
+------------+------------+
| りんご     | なし       |
| べにしぐれ | せいぎょく |
| となみ     | いなぎ     |
+------------+------------+
      TEXT
    end

    it 'renders text table with style/CENTER, RIGHT' do
      t = VisualWidth::Table.new(
        style: [{align: :center}, {align: :right}],
      )

      expect(t.render(rows)).to eql(<<-'TEXT')
+------------+------------+
|   りんご   |       なし |
| べにしぐれ | せいぎょく |
|   となみ   |     いなぎ |
+------------+------------+
      TEXT
    end

    it 'renders text table with header/footer' do
      t = VisualWidth::Table.new(
        header: %w(A B),
      )
      expect(t.render(rows)).to eql(<<-'TEXT')
+------------+------------+
|     A      |     B      |
+------------+------------+
| りんご     | なし       |
| べにしぐれ | せいぎょく |
| となみ     | いなぎ     |
+------------+------------+
      TEXT
    end

    it "does jobs with non-string elements" do
      header = ['Student', 'Mid-Terms', 'Finals']
      rows = [
        ['Sam', 94, 93],
        ['Jane', 92, 99],
        ['Average', 93, 96],
      ]

      expect(VisualWidth::Table.new(header: header).render(rows)).to eql(<<-'TEXT')
+---------+-----------+--------+
| Student | Mid-Terms | Finals |
+---------+-----------+--------+
| Sam     | 94        | 93     |
| Jane    | 92        | 99     |
| Average | 93        | 96     |
+---------+-----------+--------+
      TEXT
    end
  end

  context "#render with wrap" do
    it "wraps with 10 width" do
      t = VisualWidth::Table.new(style: [{width: 10}, {width: 10}])
      expect(t.render([['テレポーター！', '*いしのなかにいる*']])).to eql(<<-'TEXT')
+------------+------------+
| テレポータ | *いしのな  |
| ー！       | かにいる*  |
+------------+------------+
      TEXT
    end
  end
end
