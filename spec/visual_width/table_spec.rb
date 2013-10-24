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
        footer: %w(C D),
      )
      expect(t.draw(rows)).to eql(<<-'TEXT')
+----------+----------+
|    A     |    B     |
+----------+----------+
|りんご    |なし      |
|べにしぐれ|せいぎょく|
|となみ    |いなぎ    |
+----------+----------+
|    C     |    D     |
+----------+----------+
      TEXT
    end
  end
end
