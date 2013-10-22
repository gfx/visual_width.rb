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

  def count(str, east_asian = EAST_ASIAN)
    full_width = 0
    if east_asian
      str.scan(@@p1) do |m,|
        full_width += m.length
      end
    else
      str.scan(@@p0) do |m,|
        full_width += m.length
      end
    end
    (full_width * 2) + (str.length - full_width)
  end
end
