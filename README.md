# TestBookingSystem

## Requirements

### Tech requirements

- Язык руби
- Реляционная база данных(mysql, postgres, sqlite)
- Реализация включает в себя только модели, миграции

### Task

Реализовать структуру приложения для сети ресторанов.
в системе есть пользователи
в системе есть рестораны(уникальное имя)
у каждого ресторана есть столы
у каждого стола есть резервации
каждая резервация принадлежит пользователю
пользователь не может зарезервировать столы в разных ресторанах на одно время, но может зарезервировать разные столы в одном ресторане на одно время
один стол  нельзя зарезервировать двум разным людям на один промежуток времени, но если одна резервация заканчивается в 5 вечера, то следующая может начинаться в 5 вечера
длительность резервации кратна 30 минутам
у каждого ресторана есть график работы

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'test_booking_system'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install test_booking_system

## Usage

First of all you need to rolling up a migrations for test environment:

    $ rake db:create
    $ rake db:migrate RAILS_ENV=test

Now, you can launch a specs to see is code works correctly:

    $ rake spec

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/test_booking_system. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TestBookingSystem project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/test_booking_system/blob/master/CODE_OF_CONDUCT.md).
