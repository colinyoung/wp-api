# WP::API

Makes it incredibly easy and semantic to access Wordpress blogs that have the new, RESTful WP API plugin installed.

## Installation

Add this line to your application's Gemfile:

    gem 'wp-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wp-api

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
