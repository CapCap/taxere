require_relative "../../test_helper.rb"

class StateTaxCalculatorTest < Minitest::Test

  def test_calculate
    year = '2016'
    pay_rate = '1000'
    pay_periods = '52'
    filing_status = 'single'
    state = 'AL'

    response = Taxere::StateTaxCalculator.new(year, pay_rate, pay_periods, filing_status, state).calculate
    assert_match( /\d+.\d{2}/, response["data"]["state"]["amount"] )
  end

end
