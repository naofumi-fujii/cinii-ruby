# Cinii

Cinii API client library, written in Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cinii'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cinii

https://support.nii.ac.jp/ja/cinii/api/developer

## Usage
### CiNii Articles
#### Initialization

```ruby
client = Cinii::Client::Article.new(app_id: 'YOUR_APP_ID')
```

#### Search article

```ruby
result = client.list_articles(q: 'computer science')
#=> Cinii::SearchResult::Article object

# First article in search result
article = result.items.first
#=> Cinii::Item::Article object
# 
# Article title
article.title
#=> "Effect of storage and aging conditions on the flexural strength and flexural modulus of CAD/CAM materials"

article.link
#=> "https://ci.nii.ac.jp/naid/130007529119"
```
#### Full-text search
Just pass `full_text: true` to `list_articles` method.

```ruby
result = client.list_articles(q: 'computer science', full_text: true)
```

#### Search author

```ruby
result = client.list_authors(q: '山中伸弥')
#=> Cinii::SearchResult::Article object

author = result.items.first
#=> Cinii::Item::Author object

author.link
#=> "https://ci.nii.ac.jp/nrid/1000010295694"
```

### CiNii Books
#### Initialization
```ruby
# Initialization
client = Cinii::Client::Book.new(app_id: 'YOUR_APP_ID')
```

#### Search books

```ruby
result = client.list_books(q: '機械学習')
#=> Cinii::SearchResult::Book object

book = result.items.first
#=> Cinii::Item::Book object

book.title
#=> "Rによる機械学習入門"

book.link
#=> "http://ci.nii.ac.jp/ncid/BB24928243"
```

#### Search authors

```ruby
result = client.list_authors(name: '山中')
#=> Cinii::SearchResult::Book object
```

#### Search libraries

```ruby
result = client.list_libraries(name: '東京')
#=> Cinii::SearchResult::Book object

library = result.items[10]
#=> Cinii::Item::Library object

library.title
#=> "東京音楽大学 付属図書館"
```

#### Search holders

```ruby
result = client.list_holders(ncid: 'BB24928243')
#=> Cinii::SearchResult::Book object

library = result.items[25]
#=> Cinii::Item::Library object

library.title
#=> "島根大学 附属図書館"
```

### CiNii Dissertation
#### Initialization
```ruby
# Initialization
client = Cinii::Client::Dissertation.new(app_id: 'YOUR_APP_ID')
```

#### Search dissertation

```ruby
result = client.list_dissertations(author: '落合, 陽一')
#=> Cinii::SearchResult::Book object

dissertation = result.items.first
#=> Cinii::Item::Dissertation object

dissertation.title
#=> "Graphics by Computational Acoustic Fields"

dissertation.publisher
#=> "University of Tokyo(東京大学)"

dissertation.source
#=> [{:id=>"http://dl.ndl.go.jp/info:ndljp/pid/10981946", :title=>"NDLデジタルコレクション"}, {:id=>"http://hdl.handle.net/2261/00072859", :title=>"東京大学"}]
```

## TODO
- Add test
- Write API documents
- Add rest of Web API

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nashirox/cinii. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Cinii project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cinii-ruby/blob/master/CODE_OF_CONDUCT.md).
