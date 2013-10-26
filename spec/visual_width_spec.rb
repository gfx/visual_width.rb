# coding: utf-8

require 'rspec'

require 'visual_width'
require 'visual_width/string_ext'

describe VisualWidth do
  context ".measure" do
    it "measures Half characters" do
      expect(VisualWidth.measure("foo")).to eql(3)
    end
    it "measures Wide characters" do
      expect(VisualWidth.measure("こんにちは")).to eql(10)
    end

    it "measures Half characters" do
      expect(VisualWidth.measure("ｺﾝﾆﾁﾊ")).to eql(5)
    end

    it "measures Ambiguous characters" do
      expect(VisualWidth.measure("αβ")).to eql(4)
    end
  end

  context ".counnt with east_asian: false" do
    it "measures Halfwide characters" do
      expect(VisualWidth.measure("foo", east_asian: false)).to eql(3)
    end
    it "measures Wide characters" do
      expect(VisualWidth.measure("こんにちは", east_asian: false)).to eql(10)
    end

    it "measures Half characters" do
      expect(VisualWidth.measure("ｺﾝﾆﾁﾊ", east_asian: false)).to eql(5)
    end

    it "measures Ambiguous characters" do
      expect(VisualWidth.measure("αβ", east_asian: false)).to eql(2)
    end
  end

  context ".truncate" do
    it "does nothing if str is short enough" do
      expect(VisualWidth.truncate("foo", 20)).to eql("foo")
    end

    it "truncates str, adding '...'" do
      str = "The quick brown fox jumps over the lazy dog."
      s = VisualWidth.truncate(str, 15)
      expect(s.width).to be <= 15
      expect(s).to eql('The quick br...')
    end

    it "truncates str, adding '(snip)'" do
      str = "The quick brown fox jumps over the lazy dog."
      s = VisualWidth.truncate(str, 15, omission: '(snip)')
      expect(s.width).to be <= 15
      expect(s).to eql('The quick(snip)')
    end

    it "truncates Wide characters" do
      str = "くにざかいのながいトンネルを抜けるとゆきぐにであった"
      s = VisualWidth.truncate(str, 20)
      expect(s.width).to be <= 20
      expect(s).to eql('くにざかいのなが...')
    end

    it "truncates mixed character types" do
      str = "くにざかいの ながい トンネルを 抜けると ゆきぐにであった"
      s = VisualWidth.truncate(str, 20)
      expect(s.width).to be <= 20
      expect(s).to eql('くにざかいの なが...')
    end

    it "truncates Ambiguous characters" do
      str = "αβγδεζηθικλμνξοπρστυφχψω"
      s = VisualWidth.truncate(str, 10)
      expect(s.width).to be <= 10
      expect(s).to eql('αβγ...')
    end
  end

  context ".truncate with east_asian: false" do
    it "truncates str with Ambiguous characters" do
      str = "αβγδεζηθικλμνξοπρστυφχψω"
      s = VisualWidth.truncate(str, 10, east_asian: false)
      expect(s.width(east_asian: false)).to be <= 10
      expect(s).to eql('αβγδεζη...')
    end
  end

  context ".each_width" do
    it "splits str in visual width" do
      str = "恋すてふ_我が名はまだき_立ちにけり_人知れずこそ_思ひそめしか"

      values = []
      VisualWidth.each_width(str, 10) do |line|
        values << line
      end
      expect(values).to eql(%w(
        恋すてふ_
        我が名はま
        だき_立ち
        にけり_人
        知れずこそ
        _思ひそめ
        しか
      ))
    end
  end
end
