require 'visual_width'

class String
  def visual_width(opts = {})
    VisualWidth.count(self, opts)
  end

  def visual_truncate(max_length, opts = {})
    VisualWidth.truncate(self, max_length, opts)
  end
end
