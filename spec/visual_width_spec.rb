require 'rspec'

require 'visual_width'

describe VisualWidth do
  context "#count" do
    it "counts half-width str" do
      expect(VisualWidth.count("foo")).to eql(3)
    end
    it "counts Hiragana str" do
      expect(VisualWidth.count("こんにちは")).to eql(10)
    end

    it "counts Half-Katakana str" do
      expect(VisualWidth.count("ｺﾝﾆﾁﾊ")).to eql(5)
    end

    it "counts Greek str" do
      expect(VisualWidth.count("αβ")).to eql(4)
    end

    it "counts Greek str with non east-asian locale" do
      expect(VisualWidth.count("αβ", false)).to eql(2)
    end
  end
end
