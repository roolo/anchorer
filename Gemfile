source 'https://rubygems.org'

gem 'sinatra',  '~> 2.1.0'
gem 'redis',    '~> 4.2.5'
gem 'rack',     '~> 2.2.6'
gem 'puma',     '~> 5.3.2'
gem 'unicorn',  '~> 6.0.0'


group :development do
  gem 'capistrano',         '~> 3.16.0'
  gem 'capistrano-rvm',     '~> 0.1.2'
  gem 'capistrano-bundler', '~> 2.0.1'

  # for ssh-ed25519 keys
  gem 'ed25519'
  gem 'bcrypt_pbkdf'
end

group :test do
  gem 'rack-test',      '~> 1.1.0'
  gem 'guard-minitest', '~> 2.4.6'
end
