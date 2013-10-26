require 'visual_width'

module VisualWidth::Formatter
  class Align
    include VisualWidth

    def initialize(east_asian: VisualWidth::EAST_ASIAN)
      @east_asian = east_asian
    end

    def left(cell, width)
      align(cell, width) do |line, fill|
        line + (' ' * fill)
      end
    end

    def right(cell, width)
      align(cell, width) do |line, fill|
        (' ' * fill) + line
      end
    end

    def center(cell, width)
      align(cell, width) do |line, fill|
        half = fill / 2.0
        (' ' * half.floor) + line + (' ' * half.ceil)
      end
    end

    private

    def align(cell, width)
      w = measure(cell, east_asian: @east_asian)
      if w > width
        raise ArgumentError, "Invalid width cell: #{cell.inspect}, width: #{width.inspect}"
      end
      yield cell, width - w
    end
  end
end
