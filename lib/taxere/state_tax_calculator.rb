require "taxere/tax_calculator_base"

module Taxere
  class StateTaxCalculator < ::Taxere::TaxCalculatorBase

    def calculate(year, pay_rate, pay_periods, filing_status, state)
      @response["data"]["state"]["amount"] = self.get_state_tax_amount(year, pay_rate * pay_periods, filing_status, state)
      @response
    end

    def get_state_tax_amount(year, income, filing_status, state_abbr)
      state_data = self.get_state_data(year, state_abbr)
      target_table = state_data["data"][filing_status]

      get_income_tax_amount(target_table, income)
    end

    def get_state_data(year, state_abbr)
      state = ::Taxere::StateConstants::SHORT_TO_FULL_MAP[state_abbr]
      get_tax_table(year.to_s, state)
    end

  end
end
