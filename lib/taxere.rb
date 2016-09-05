require "taxere/version"
require "taxere/federal_tax_calculator"
require "taxere/state_tax_calculator"
require "taxere/tax_calculator_base"

# "/v1/federal/:year/"            # get_federal_data
# "/v1/state/:state/:year/"       # get_state_data
# "/v1/calculate/:year/"          # calculates both state + federal

module Taxere
  class<< self

    def calculate_income_taxes(year, pay_rate, pay_periods, filing_status, state)
      response = ::Taxere::TaxCalculatorBase.new_nice_hash
      response["success"] = false

      federal_taxes = ::Taxere::FederalTaxCalculator.new.calculate(year, pay_rate, pay_periods, filing_status)
      state_taxes = ::Taxere::TaxCalculatorBase.new_nice_hash
      unless state.empty?
        state_taxes = StateTaxCalculator.new.calculate(year, pay_rate, pay_periods, filing_status, state)
      end
      response["data"]["annual"] = federal_taxes["data"].merge(state_taxes["data"])

      if pay_periods > 1
        response['data']['per_pay_period'] = []
        response['data']['annual'].each do |k, v|
          response['data']['per_pay_period'][k] = { "amount" => (v['amount'] / pay_periods) }
        end
      end

      response["success"] = true

      response
    end

  end
end
