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


  @@c1 = /( (?:#{Fullwide} | #{Wide} | #{Ambiguous})+ )/x
  @@c0 = /( (?:#{Fullwide} | #{Wide}               )+ )/x

  @@t1 = /( (?:#{Fullwide} | #{Wide} | #{Ambiguous}) ) | ./x
  @@t0 = /( (?:#{Fullwide} | #{Wide}               ) ) | ./x

  module_function

  def count(str, east_asian: EAST_ASIAN)
    rx = east_asian ? @@c1 : @@c0
    full_width = 0
    str.scan(rx) do |w,|
      full_width += w.length
    end
    (full_width * 2) + (str.length - full_width)
  end

  def truncate(str, max_length, omission: '...', east_asian: EAST_ASIAN)
    max = max_length - omission.length
    rx = east_asian ? @@t1 : @@t0
    pos = 0
    width = 0
    str.scan(rx) do |wide,|
      if wide
        width += 2
      else
        width += 1
      end

      if width > max
        break
      end

      pos += 1

      if width == max
        break
      end
    end

    if width < str.length
      str.slice(0, pos) + omission
    else
      str
    end
  end
end
