require_relative '../../test_helper'

class TestConstants < Minitest::Test

  def test_supported_year
    assert( Taxere::Constants.supports_year?("2016") )
  end

  def test_tax_table_happy_path
    test_year  = '2016'
    test_state = 'New York'
    assert( Taxere::Constants.get_tax_table(test_year, test_state) )
  end

end
