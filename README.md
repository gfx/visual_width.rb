# VisualWidth [![Build Status](https://travis-ci.org/gfx/visual_width.rb.png?branch=master)](https://travis-ci.org/gfx/visual_width.rb)

This gem handles Unicode East Asian Width:

* http://www.unicode.org/reports/tr11/

## Installation

Add this line to your application's Gemfile:

    gem 'visual_width'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install visual_width

## Usage

```ruby
    require 'visual_width'

    p VisualWidth.measure("こんにちは") # => 10
    p VisualWidth.measure("abcdefghij") # => 10

    p VisualWidth.truncate("恋すてふ 我が名はまだき 立ちにけり 人知れずこそ 思ひそめしか", 20) # => "恋すてふ 我が名は..."
```

Each method can take `east_asian: false` to tell it is not in an East Asian context, regarding ambiguous characters as half-width.

See [Ambiguous Characters](http://www.unicode.org/reports/tr11/#Ambiguous) in the report.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## See Also

* [unicode-display_width](https://rubygems.org/gems/unicode-display_width) has the same feature as `VisualWidth.measure()` but it extends String class directly and is much slower than `VisualWidth.measure()`
