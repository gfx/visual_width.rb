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

  def each_width(str, max_width, east_asian: EAST_ASIAN) # requires block
    rx = east_asian ? @@t1 : @@t0
    pos = 0
    width = 0
    str.scan(rx) do |wide,|
      width += wide ? 2 : 1
      pos += 1

      next_char = str[pos]
      next_char_width = next_char ? measure(next_char, east_asian: east_asian) : 0
      if (width + next_char_width) > max_width
        yield str.slice(0, pos)
        str = str.slice(pos, str.length)
        pos = 0
        width = 0
      end
    end
    if str.length > 0
      yield str
    end
  end

  def truncate(str, max_length, omission: '...', east_asian: EAST_ASIAN)
    max = max_length - omission.length
    each_width(str, max, east_asian: east_asian) do |line|
      if line.length == str.length
        return line
      else
        return line + omission
      end
    end
  end
end
