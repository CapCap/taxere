require_relative '../../test_helper.rb'

class TestTaxCalculatorBase < Minitest::Test

  CALC = Taxere::TaxCalculatorBase.new

  #
  # get_tax_table
  #

  def test_get_tax_table_happy_path
    res = get_tax_table
    assert_equal(true, res['success'])
  end

  def test_get_tax_table_with_invalid_year
    res = get_tax_table('2013')
    assert_equal(false, res['success'])
  end

  def test_get_tax_table_with_invalid_state
    res = get_tax_table('New Joisey')
    assert_equal(false, res['success'])
  end

  # helpers

  def get_tax_table(year='2016', state='New York')
    CALC.get_tax_table(year, state)
  end

  #
  # get_income_tax_amount
  #

  def test_get_income_tax_amount_happy_path
    amount = get_income_tax
    assert_equal(1500.00, amount.to_f.round(2) )
  end

  # helpers

  # adjusted should be 90k
  # first $79999.99 at 1% should come to $800.00
  # next  $10k      at 7% should come to $700.00
  # total should be $1500.00

  def get_income_tax
    CALC.get_income_tax_amount(get_target_table, 100000)
  end

  def get_target_table
    ::JSON.parse <<-HERE
      {
        "deductions": [
          {
            "deduction_amount": 10000
          }
        ],
        "income_tax_brackets": [
          {
            "bracket": 0,
            "marginal_rate": 1
          },
          {
            "bracket": 80000,
            "marginal_rate": 7
          }
        ]
      }
    HERE
  end

end