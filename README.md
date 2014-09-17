# WP::API

Makes it incredibly easy and semantic to access Wordpress blogs that have the new, RESTful WP API plugin installed.

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
```

## Author

@colinyoung
