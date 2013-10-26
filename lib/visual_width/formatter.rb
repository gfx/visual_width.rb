require 'visual_width'

module VisualWidth::Formatter
  class Align
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
      w = VisualWidth.measure(cell)
      if w > width
        raise ArgumentError, "Invalid width cell: #{cell.inspect}, width: #{width.inspect}"
      end
      yield cell, width - w
    end
  end
end
