require 'visual_width'

class VisualWidth::Table
  attr_accessor :header, :footer, :format

  # align (left, right, center)
  LEFT = -> (cell, fill) {
    cell + (' ' * fill)
  }

  RIGHT = -> (cell, fill) {
    (' ' * fill) + cell
  }

  CENTER = -> (cell, fill) {
    half = fill / 2.0
    (' ' * half.floor) + cell + (' ' * half.ceil)
  }

  def initialize(header: nil, format: [])
    @header = header
    @format = format
  end

  def draw(rows, header: nil, output: "")
    max_widths = calc_max_widths(rows)
    h = header || @header
    if h
      max_widths = h.map { |cell| VisualWidth.measure(cell) }
        .zip(max_widths)
        .map { |values| values.max }
      format_header = [CENTER] * h.length
    else
      format_header = nil
    end
    draw_row(output, max_widths, format_header, h, separated: true)
    rows.each do |row|
      draw_row(output, max_widths, @format, row)
    end
    line(output, max_widths)
    output
  end
  private

  def draw_row(output, max_widths, format, row, separated: false)
    if separated
      line(output, max_widths)
    end

    if row
      output << '|'
      row.each_with_index do |cell, i|
        fill(output, max_widths[i], cell.to_s, format[i])
        output << '|'
      end
      output << "\n"

      if separated
        line(output, max_widths)
      end
    end
  end

  def line (output, max_widths)
    output << '+' << max_widths.map { |width| '-' * width }.join('+') << "+\n"
  end

  def fill(output, max_width, cell, f)
    f ||= LEFT
    w = VisualWidth.measure(cell)
    output << f.call(cell, (max_width - w))
  end

  def calc_max_widths(rows) # -> [max_col0_width, max_col1_width, ...]
    result = []
    rows.each_with_index do |row|
      row.each_with_index do |cell, i|
        result[i] = [result[i] || 0, VisualWidth.measure(cell.to_s)].max
      end
    end
    result
  end
end
