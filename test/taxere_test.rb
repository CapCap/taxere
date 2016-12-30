require_relative "test_helper"

class TaxereTest < Minitest::Test

  def setup
    @year          = '2016'
    @pay_rate      = '2000'
    @pay_periods   = '50'
    @filing_status = 'married'
    @state         = 'CA'
  end

  def get_response
    ::Taxere.calculate_income_taxes(@year, @pay_rate, @pay_periods, @filing_status, @state)
  end

  def get_response_with_no_state
    ::Taxere.calculate_income_taxes(@year, @pay_rate, @pay_periods, @filing_status, '')
  end

  def test_calculate_income_taxes_with_state
    response = get_response
    assert(response['success'])
    assert(response['data']['annual']['federal']['amount'].to_f > 0)
    assert(response['data']['annual']['state']['amount'].to_f > 0)

    # puts JSON.pretty_generate response
  end

  def test_calculate_income_taxes_without_state
    response = get_response_with_no_state
    assert(response['success'])
    assert(response['data']['annual']['federal']['amount'].to_f > 0)
    refute(response['data']['annual'].key? 'state')
    
    # puts JSON.pretty_generate response
  end


end