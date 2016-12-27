require "taxere/tax_calculator_base"

module Taxere
  class FederalTaxCalculator < ::Taxere::TaxCalculatorBase

    def initialize(year, pay_rate, pay_periods, filing_status)
      @year          = year.to_s
      @pay_rate      = BigDecimal.new(pay_rate.to_s)
      @pay_periods   = pay_periods.to_i
      @filing_status = filing_status

      @response      = self.class.new_nice_hash
    end

    def calculate
      @response["success"] = true
      @response["data"]["fica"]["amount"]    = self.class.format_dollars get_fica_tax_amount
      @response["data"]["federal"]["amount"] = self.class.format_dollars get_federal_income_tax_amount

      @response
    end

    def get_federal_data(year)
      get_tax_table(year.to_s, "federal")
    end

    private

    def get_federal_income_tax_amount
      get_income_tax_amount(target_table, income)
    end


    def get_fica_tax_amount
      income * (::Taxere::Constants::SSA_RATE + ::Taxere::Constants::MEDICARE_RATE)
    end

    def income
      @pay_rate * @pay_periods
    end

    def tax_table
      get_federal_data(@year)["data"]
    end

    def target_table
      pay_schedule = "annual"
      tax_table["tax_withholding_percentage_method_tables"][pay_schedule][@filing_status]
    end
  end
end
