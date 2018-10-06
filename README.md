# Anki::Wotd

Get the Word of the Day (wotd) from http://www.wordthink.com/ and the definition from https://www.oxforddictionaries.com/ and create an anki card using https://github.com/FooSoft/anki-connect.

## Installation

Download the repo and run the following commands:

```ruby
gem build anki-wotd.gemspec
gem install anki-wotd-[version].gem
```

## Usage

To lookup all the words from  http://www.wordthink.com/ and create cards, run:

```
$ anki-wotd
```

To add your own list of word(s), use the following space deliniated words:

```
$ anki-wotd --words="gregarious existential"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/anki-wotd. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Anki::Wotd project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/anki-wotd/blob/master/CODE_OF_CONDUCT.md).
