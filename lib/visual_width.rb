require "visual_width/version"
require "visual_width/data"

module VisualWidth
  EAST_ASIAN = true

  module_function

  def count(str, east_asian = EAST_ASIAN)
    full_width = 0
    if east_asian
      str.scan(/( (?:#{Fullwide} | #{Wide} | #{Ambiguous})+ )/x) do |m,|
        full_width += m.length
      end
    else
      str.scan(/( (?:#{Fullwide} | #{Wide})+ )/x) do |m,|
        full_width += m.length
      end
    end
    (full_width * 2) + (str.length - full_width)
  end
end
