require "taxere/version"
require "taxere/federal_tax_calculator"
require "taxere/state_tax_calculator"
require "taxere/tax_calculator_base"

# "/v1/federal/:year/"            # get_federal_data
#        # get_state_data
# "/v1/calculate/:year/"          # calculates both state + federal

module Taxere
  class<< self

    def calculate_income_taxes(year, pay_rate, pay_periods, filing_status, state)

      year        = year.to_s
      pay_rate    = BigDecimal.new(pay_rate.to_s)
      pay_periods = pay_periods.to_i

      response = ::Taxere::TaxCalculatorBase.new_nice_hash
      response["success"] = false

      federal_taxes = ::Taxere::FederalTaxCalculator.new(year, pay_rate, pay_periods, filing_status).calculate
      response["data"]["annual"] = federal_taxes["data"]

      unless state.to_s.empty?
        state_taxes = StateTaxCalculator.new(year, pay_rate, pay_periods, filing_status, state).calculate
        response["data"]["annual"].merge!(state_taxes["data"])
      end

      if pay_periods > 1
        response['data']['per_pay_period'] = response['data']['annual'].reduce({}) do |out, pair|
            key, amount = pair[0], BigDecimal.new( pair[1]['amount'] )
            ppp = amount / pay_periods
            ppp = "%.02f" % ppp
            out.merge! key => {"amount": ppp}
        end
      end

      response["success"] = true
      response
    end
  end
end
