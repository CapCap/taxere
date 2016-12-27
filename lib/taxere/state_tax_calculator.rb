require "taxere/tax_calculator_base"

module Taxere
  class StateTaxCalculator < ::Taxere::TaxCalculatorBase

    def initialize(year, pay_rate, pay_periods, filing_status, state)
      @year          = year.to_s
      @pay_rate      = BigDecimal.new(pay_rate.to_s)
      @pay_periods   = pay_periods.to_i
      @filing_status = filing_status
      @state_abbrev  = state
    end

    def calculate
      response = self.class.new_nice_hash
      response["data"]["state"]["amount"] = "%.02f" % state_tax_amount
      response
    end

    private

    def state_tax_amount
      get_income_tax_amount(target_table, income)
    end

    def target_table
      get_state_data["data"][@filing_status]
    end

    def income
      @pay_rate * @pay_periods
    end

    def get_state_data
      state = StateConstants::SHORT_TO_FULL_MAP[@state_abbrev]
      get_tax_table(@year, state)
    end

  end
end
