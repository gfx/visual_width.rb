# VisualWidth [![Build Status](https://travis-ci.org/gfx/visual_width.rb.png?branch=master)](https://travis-ci.org/gfx/visual_width.rb)
TODO: Write a gem description

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

    p VisualWidth.count("こんにちは") # => 10
    p VisualWidth.count("abcdefghij") # => 10

    p VisualWidth.truncate("恋すてふ 我が名はまだき 立ちにけり 人知れずこそ 思ひそめしか", 20) # => "恋すてふ 我が名は..."
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
