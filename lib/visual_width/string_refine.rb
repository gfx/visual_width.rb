require 'visual_width'

module VisualWidth
  refine String do
    def width(opts = {})
      VisualWidth.measure(self, opts)
    end

    def truncate(max_length, opts = {})
      VisualWidth.truncate(self, max_length, opts)
    end
  end
end
