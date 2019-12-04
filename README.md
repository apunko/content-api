# Content API

A basic implementation of json api. Without production purposes. Just for training.

## Development env setup

Standard steps for rails app
* ```bundle install```
* ```rails db:create; rails db:migrate```

Optional:

Set up [Overcommit](https://github.com/sds/overcommit/)
to run [Rubocop](https://github.com/rubocop-hq/rubocop) before commits and tests before push. I use it for convenience. 

Overcommit is base on git hooks.

## Development Server

```rails s``` and in a separate tab ```bundle exec sidekiq```

Caching is disabled in dev environment. Modify  ```config/environments/development.rb``` to get it running.

## Tests

[Rspec](https://github.com/rspec/rspec-rails/) is testing framework.

[FactoryBot](https://github.com/thoughtbot/factory_bot/) - factories (fixture replacement). 

Run tests ```rspec spec```
