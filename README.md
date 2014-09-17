# WP::API

Makes it incredibly easy and semantic to access Wordpress blogs that have the new, RESTful WP API plugin installed.

## Installation

    gem 'wp-api'
    bundle

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
