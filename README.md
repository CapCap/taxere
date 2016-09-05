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

Alternatively, you can just see what data we have:
```ruby
require "taxere/state_tax_calculator"
::Taxere::StateTaxCalculator.new.get_state_data(year, state_abbr)
```
```ruby
require "taxere/federal_tax_calculator"
::Taxere::FederalTaxCalculator.new.get_federal_data(year)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/capcap/taxere](https://github.com/capcap/taxere).

