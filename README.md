# WP::API

[![Circle CI](https://circleci.com/gh/colinyoung/wp-api.png?style=badge)](https://circleci.com/gh/colinyoung/wp-api)

Makes it incredibly easy and semantic to access Wordpress blogs that have the [WP REST API plugin](http://wp-api.org/) installed (which is planned for full integration into wordpress core soon.)

## Installation

    gem 'wp-api'
    bundle

## Note

This gem requires Ruby 2.0, which is the [oldest currently supported version of Ruby](https://www.ruby-lang.org/en/news/2014/07/01/eol-for-1-8-7-and-1-9-2/).

## Usage

```ruby
client = WP::API['yourwpsite.com']

# List all posts
client.posts

# List all users
client.users

# List alternate post types
client.posts(type: 'custom_posts')

# Append paramters
client.posts(posts_per_page: 1000)

# Use basic auth (used to access post meta)
client = WP::API::Client.new(host: 'yourwpsite.com', scheme: 'https', user: 'api', password: 'apipassword')
client.post_meta(1234) # => metadata for post #1234
```

## Author

@colinyoung

