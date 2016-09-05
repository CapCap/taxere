require "taxere/tax_calculator_base"

module Taxere
  class FederalTaxCalculator < ::Taxere::TaxCalculatorBase

    def calculate(year, pay_rate, pay_periods, filing_status)
      @response["success"] = true
      @response["data"]["fica"]["amount"] = self.get_fica_tax_amount(pay_rate * pay_periods, filing_status)
      @response["data"]["federal"]["amount"] = self.get_federal_income_tax_amount(year, pay_rate * pay_periods, filing_status)
      @response
    end

    def get_federal_income_tax_amount(year, income, filing_status)
      tax_table = get_federal_data(year)["data"]
      pay_schedule = "annual"
      target_table = tax_table["tax_withholding_percentage_method_tables"][pay_schedule][filing_status]

      get_income_tax_amount(target_table, income)
    end


    def get_fica_tax_amount(income, is_married)
      amount = income * (::Taxere::Constants::SSA_RATE + ::Taxere::Constants::MEDICARE_RATE)
      round(amount, 2)
    end

    def get_federal_data(year)
      get_tax_table(year.to_s, "federal")
    end

  end
end
