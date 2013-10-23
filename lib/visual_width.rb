require "visual_width/version"
require "visual_width/data"

module VisualWidth
  EAST_ASIAN = true

  if RUBY_VERSION >= "2.1.0"
    refine String do
      def visual_width(east_asian = EAST_ASIAN)
        VisualWidth.count(self)
      end
    end
  end

  module_function

  @@p1 = /( (?:#{Fullwide} | #{Wide} | #{Ambiguous})+ )/x
  @@p0 = /( (?:#{Fullwide} | #{Wide}               )+ )/x

  def count(str, east_asian: EAST_ASIAN)
    full_width = 0
    rx = east_asian ? @@p1 : @@p0
    str.scan(rx) do |m,|
      full_width += m.length
    end
    (full_width * 2) + (str.length - full_width)
  end
end
