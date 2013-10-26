require 'visual_width'
require 'visual_width/formatter'

class VisualWidth::Table
  include VisualWidth

  attr_accessor :header, :style

  def initialize(header: nil, style: [], east_asian: VisualWidth::EAST_ASIAN)
    @header = header
    @style  = style.clone
    @east_asian = east_asian

    if header
      header.length.times do |i|
        @style[i] ||= {}
      end
    end

    widths = @style.map { |s| s[:width] }
    @needs_wrap = widths.any?
    if header
      @header_widths = calc_max_widths([header])
    end
  end

  def render(rows, output: "")
    if @needs_wrap
      rows = rows.map do |row|
        i = 0
        row.map do |cell|
          cell = "#{cell}"
          style = (@style[i] ||= {})
          width = style[:width]
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
    if @header
      header_style = []
      max_widths = @header_widths
        .zip(max_widths)
        .map { |values| values.max }
      @header.length.times do |i|
        style = (@style[i] ||= {})
        header_style << style.merge(align: :center)
      end
      draw_header(output, max_widths, header_style, @header)
    else
      line(output, max_widths)
    end

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
      st = (style[i] ||= {})
      align = st[:align] || :left
      width = st[:width] || max_widths[i]
      c = cell.split(/\n/)
      if c.length == 0
        c << ""
      end
      output << ' ' << aligner.send(align, c.shift.strip, width) << ' '
      output << '|'
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
    output << '+' << widths.map { |width| '-' * (width+2) }.join('+') << "+\n"
  end

  def aligner
    VisualWidth::Formatter::Align.new(east_asian: @east_asian)
  end

  def calc_max_widths(rows) # -> [max_col0_width, max_col1_width, ...]
    result = Array.new((@header || rows[0] || []).length, 0)
    rows.each_with_index do |row|
      row.each_with_index do |cell, i|
        ws = "#{cell}".split(/\n/).map do |line|
          measure(line, east_asian: @east_asian)
        end
        style = (@style[i] ||= {})
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
