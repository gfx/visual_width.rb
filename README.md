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

## `visual_width`:

```ruby
    p VisualWidth.measure("こんにちは") # => 10
    p VisualWidth.measure("abcdefghij") # => 10

    p VisualWidth.truncate("恋すてふ 我が名はまだき 立ちにけり 人知れずこそ 思ひそめしか", 20) # => "恋すてふ 我が名は..."
```

`.measure()` and `truncate()` methods takes `east_asian: false` option to tell it is not in an East Asian context, regarding ambiguous characters as half-width.
See [Ambiguous Characters](http://www.unicode.org/reports/tr11/#Ambiguous) in the report.

## `visual_width/table`:

```ruby
    require 'visual_width/table'

    t = VisualWidth::Table.new(
      style: [
        { align: :center, width:  8 },
        { align: :center, width:  8 },
        { align: :right,  width:  5 },
      ],
      header: ['Nick', 'FullName', 'Age'],
    )

    rows = [
      ['カネダ', '金田 正太郎', 17],
      ['テツオ', '島 鉄雄', 16],
      ['ケイ', '?', 18],
    ]
    puts t.render(rows)
    # +--------+--------+-----+
    # |  Nick  |FullName| Age |
    # +--------+--------+-----+
    # | カネダ |金田 正 |   17|
    # |        |  太郎  |     |
    # | テツオ |島 鉄雄 |   16|
    # |  ケイ  |   ?    |   18|
    # +--------+--------+-----+
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## See Also

* [unicode-display_width](https://rubygems.org/gems/unicode-display_width) has the same feature as `VisualWidth.measure()` but it extends String class directly and is much slower than `VisualWidth.measure()`
* [terminal-table](https://rubygems.org/gems/terminal-table) renders text table, but it cannot deal with East Asian Width characters
