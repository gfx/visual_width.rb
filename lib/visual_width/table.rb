require 'visual_width'
require 'visual_width/formatter'

class VisualWidth::Table
  include VisualWidth

  attr_accessor :header, :style

  def initialize(header: nil, style: [])
    @header = header
    @style  = style

    @needs_wrap = @style.any? { |style| style[:width] != nil }
  end

  def render(rows, header: nil, output: "")
    if @needs_wrap
      default_style = {}
      rows = rows.map do |row|
        i = 0
        row.map do |cell|
          cell = "#{cell}"
          width = (@style[i] || default_style)[:width]
          i += 1
          if width
            wrap(cell, width)
          else
            cell
          end
        end
      end
    end
    max_widths = calc_max_widths(rows)
    h = header || @header
    style_header = []
    if h
      max_widths = calc_max_widths([h])
        .zip(max_widths)
        .map { |values| values.max }
      h.length.times do |i|
        style = @style[i] || {}

        style_header << style.merge(align: :center)
      end
    end
    draw_header(output, max_widths, style_header, h)
    rows.each do |row|
      draw_row(output, max_widths, @style, row)
    end
    line(output, max_widths)
    output
  end

  def draw(*args)
    warn "draw() is deprecated. Use render() instead."
    render(*args)
  end

  private

  def draw_header(output, max_widths, style, row)
    line(output, max_widths)

    if row && row.length > 0
      draw_row(output, max_widths, style, row)
      line(output, max_widths)
    end
  end

  def draw_row(output, max_widths, style, row)
    output << '|'

    rows = []
    max_widths.length.times do |i|
      cell = "#{row[i]}"
      s = style[i] || {}
      align = s[:align] || :left
      width = s[:width] || max_widths[i]
      c = cell.split(/\n/)
      if c.length == 0
        c << ""
      end
      output << aligner.send(align, c.shift.strip, width) << '|'
      if c.length > 0
        c.each_with_index do |new_cell, row_id|
          rows[row_id] ||= []
          rows[row_id][i] = new_cell
        end
      end
    end
    output << "\n"

    rows.each do |row|
      draw_row(output, max_widths, style, row)
    end

    output
  end

  def line (output, widths)
    output << '+' << widths.map { |width| '-' * width }.join('+') << "+\n"
  end

  def aligner
    VisualWidth::Formatter::Align.new
  end

  def calc_max_widths(rows) # -> [max_col0_width, max_col1_width, ...]
    result = []
    default_style = {}
    rows.each_with_index do |row|
      row.each_with_index do |cell, i|
        ws = "#{cell}".split(/\n/).map do |line|
          measure(line)
        end
        style = @style[i] || default_style
        result[i] = (ws << (result[i] || 0) << (style[:width] || 0)).max
      end
    end
    result
  end

  def wrap(cell, width)
    s = ""
    each_width(cell.strip, width) do |line|
      s << line.strip << "\n"
    end
    s
  end
end
