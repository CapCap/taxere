# Taxere

A ruby port of [Taxee](https://github.com/clearlyandy/Taxee) (originally PHP) 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'taxere'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install taxere

## Usage

To calculate state/federal taxes, you can do 
```ruby
require 'taxere'
::Taxere::calculate_income_taxes(year, pay_rate, pay_periods, filing_status, state)
```
Omitting state will return just the calculated federal tax amount.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/capcap/taxere.

