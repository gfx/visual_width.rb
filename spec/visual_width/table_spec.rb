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

  context "#draw" do
    it 'draws text table' do
      t = VisualWidth::Table.new

      expect(t.draw(rows)).to eql(<<-'TEXT')
+----------+----------+
|りんご    |なし      |
|べにしぐれ|せいぎょく|
|となみ    |いなぎ    |
+----------+----------+
      TEXT
    end

    it 'draws text table with formatter/CENTER, RIGHT' do
      t = VisualWidth::Table.new(
        format: [VisualWidth::Table::CENTER, VisualWidth::Table::RIGHT],
      )

      expect(t.draw(rows)).to eql(<<-'TEXT')
+----------+----------+
|  りんご  |      なし|
|べにしぐれ|せいぎょく|
|  となみ  |    いなぎ|
+----------+----------+
      TEXT
    end

    it 'draws text table with header/footer' do
      t = VisualWidth::Table.new(
        header: %w(A B),
      )
      expect(t.draw(rows)).to eql(<<-'TEXT')
+----------+----------+
|    A     |    B     |
+----------+----------+
|りんご    |なし      |
|べにしぐれ|せいぎょく|
|となみ    |いなぎ    |
+----------+----------+
      TEXT
    end

    it "does jobs with non-string elements" do
      header = ['Student', 'Mid-Terms', 'Finals']
      rows = [
        ['Sam', 94, 93],
        ['Jane', 92, 99],
        ['Average', 93, 96],
      ]

      expect(VisualWidth::Table.new.draw(rows, header: header)).to eql(<<-'TEXT')
+-------+---------+------+
|Student|Mid-Terms|Finals|
+-------+---------+------+
|Sam    |94       |93    |
|Jane   |92       |99    |
|Average|93       |96    |
+-------+---------+------+
      TEXT
    end
  end
end
