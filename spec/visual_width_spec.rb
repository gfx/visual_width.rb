require 'rspec'

require 'visual_width'
require 'visual_width/string_ext'

describe VisualWidth do
  context ".count" do
    it "counts Half characters" do
      expect(VisualWidth.count("foo")).to eql(3)
    end
    it "counts Wide characters" do
      expect(VisualWidth.count("こんにちは")).to eql(10)
    end

    it "counts Half characters" do
      expect(VisualWidth.count("ｺﾝﾆﾁﾊ")).to eql(5)
    end

    it "counts Ambiguous characters" do
      expect(VisualWidth.count("αβ")).to eql(4)
    end
  end

  context ".counnt with east_asian: false" do
    it "counts Halfwide characters" do
      expect(VisualWidth.count("foo", east_asian: false)).to eql(3)
    end
    it "counts Wide characters" do
      expect(VisualWidth.count("こんにちは", east_asian: false)).to eql(10)
    end

    it "counts Half characters" do
      expect(VisualWidth.count("ｺﾝﾆﾁﾊ", east_asian: false)).to eql(5)
    end

    it "counts Ambiguous characters" do
      expect(VisualWidth.count("αβ", east_asian: false)).to eql(2)
    end
  end

  context ".truncate" do
    it "does nothing if str is short enough" do
      expect(VisualWidth.truncate("foo", 20)).to eql("foo")
    end

    it "truncates str, adding '...'" do
      str = "The quick brown fox jumps over the lazy dog."
      s = VisualWidth.truncate(str, 15)
      expect(s.visual_width).to be <= 15
      expect(s).to eql('The quick br...')
    end

    it "truncates str, adding '(snip)'" do
      str = "The quick brown fox jumps over the lazy dog."
      s = VisualWidth.truncate(str, 15, omission: '(snip)')
      expect(s.visual_width).to be <= 15
      expect(s).to eql('The quick(snip)')
    end

    it "truncates Wide characters" do
      str = "くにざかいのながいトンネルを抜けるとゆきぐにであった"
      s = VisualWidth.truncate(str, 20)
      expect(s.visual_width).to be <= 20
      expect(s).to eql('くにざかいのなが...')
    end

    it "truncates mixed character types" do
      str = "くにざかいの ながい トンネルを 抜けると ゆきぐにであった"
      s = VisualWidth.truncate(str, 20)
      expect(s.visual_width).to be <= 20
      expect(s).to eql('くにざかいの なが...')
    end

    it "truncates Ambiguous characters" do
      str = "αβγδεζηθικλμνξοπρστυφχψω"
      s = VisualWidth.truncate(str, 10)
      expect(s.visual_width).to be <= 10
      expect(s).to eql('αβγ...')
    end
  end

  context ".truncate with east_asian: false" do
    it "truncates str with Ambiguous characters" do
      str = "αβγδεζηθικλμνξοπρστυφχψω"
      s = VisualWidth.truncate(str, 10, east_asian: false)
      expect(s.visual_width(east_asian: false)).to be <= 10
      expect(s).to eql('αβγδεζη...')
    end
  end
end
