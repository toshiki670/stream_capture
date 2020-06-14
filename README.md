<a href="LICENSE" alt="MIT License"><img alt="GitHub" src="https://img.shields.io/github/license/toshiki670/stream_capture?style=flat-square"></a>
<a href="https://github.com/toshiki670/stream_capture/actions" alt="Check action"><img alt="GitHub" src="https://img.shields.io/github/workflow/status/toshiki670/stream_capture/Ruby?label=Ruby&style=flat-square"></a>
<a href="https://rubygems.org/gems/stream_capture" alt="Rubygems"><img alt="GitHub" src="https://img.shields.io/gem/dt/stream_capture?style=flat-square"></a>
<a href="https://rubygems.org/gems/stream_capture" alt="Rubygems"><img alt="GitHub" src="https://img.shields.io/gem/v/stream_capture?style=flat-square"></a>

# StreamCapture
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stream_capture'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install stream_capture

## Usage
1. First, `require 'stream_capture'`

### as Module (include)
```
class YourClass
  include StreamCapture
end

klass = YourClass.new

result = klass.capture_std_both do
  puts "result stdout"
  warn "result stderr"
  exit 0
end

p result
>> result stdout
>> result stderr
>> 0
```
### as Module method
```
result = StreamCapture.std_both do
  puts "result stdout"
  warn "result stderr"
  exit 0
end

p result
>> result stdout
>> result stderr
>> 0
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/toshiki670/stream_capture). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/toshiki670/stream_capture/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StreamCapture project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/toshiki670/stream_capture/blob/master/CODE_OF_CONDUCT.md).
