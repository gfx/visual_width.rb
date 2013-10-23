require 'rspec'

require 'visual_width/string_refine'

using VisualWidth

describe VisualWidth do
  context "String#width" do
    it do
      expect("こんにちは".width).to eql(10)
    end
  end

  context "String#width" do
    it do
      expect("こんにちは".truncate(5)).to eql('こ...')
    end
  end
end