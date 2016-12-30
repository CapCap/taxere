require_relative "../../test_helper.rb"

class FederalTaxCalculatorTest < Minitest::Test

  def test_calculate
    year = '2016'
    pay_rate = 1000
    pay_periods = 52
    filing_status = 'married'

    calc = Taxere::FederalTaxCalculator.new(year, pay_rate, pay_periods, filing_status)
    # puts JSON.pretty_generate calc.calculate
    assert calc.calculate["success"] == true
  end

end