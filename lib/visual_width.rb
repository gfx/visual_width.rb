require "visual_width/version"
require "visual_width/data"

module VisualWidth
  EAST_ASIAN = true

  r1 = /#{Fullwide} | #{Wide} | #{Ambiguous}/x;
  r0 = /#{Fullwide} | #{Wide}               /x;

  @@c1 = /( #{r1}+ )/x
  @@c0 = /( #{r0}+ )/x

  @@t1 = /( #{r1} ) | . /x
  @@t0 = /( #{r0} ) | . /x

  module_function

  def count(*args)
    warn "count() is deprecated. use measure() instead"
    measure(*args)
  end

  def measure(str, east_asian: EAST_ASIAN)
    rx = east_asian ? @@c1 : @@c0
    full_width = 0
    str.scan(rx) do |wide,|
      full_width += wide.length
    end
    (full_width * 2) + (str.length - full_width)
  end

  def truncate(str, max_length, omission: '...', east_asian: EAST_ASIAN)
    rx = east_asian ? @@t1 : @@t0
    max = max_length - omission.length
    pos = 0
    width = 0
    str.scan(rx) do |wide,|
      width += wide ? 2 : 1

      break if width > max

      pos += 1

      break if width == max
    end

    if width < str.length
      str.slice(0, pos) + omission
    else
      str
    end
  end
end
