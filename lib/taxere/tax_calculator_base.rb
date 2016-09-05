require "bigdecimal"
require "taxere/constants"
require "taxere/state_constants"
require "taxere/nice_hash"

module Taxere
  class TaxCalculatorBase

    attr_reader :response

    def initialize
      @response = ::Taxere::TaxCalculatorBase.new_nice_hash
    end

    def get_tax_table(year, state)
      @response["success"] = false
      if state.to_s.empty?
        @response["reason"] = "Invalid State"
      elsif !::Taxere::Constants.supports_year?(year)
        @response["reason"] = "Invalid Year"
      else
        @response["success"] = true
        @response["data"] = ::Taxere::Constants::get_tax_table(year.to_s, state.downcase.gsub(" ", "_"))
      end

      @response
    end

    def get_income_tax_amount(target_table, income)
      deduction_amount = 0
      Array(target_table["deductions"]).each do |deduction|
        deduction_amount += deduction["deduction_amount"].to_i
      end

      exemption_amount = 0
      unless target_table["exemptions"].to_s.empty? || target_table["exemptions"]["personal"].to_s.empty?
        # exemptions = target_table["exemptions"]["personal"].to_i
      end

      adjusted_income = [income - deduction_amount - exemption_amount, 0].max

      amount = ::BigDecimal.new(0, 8)

      Array(target_table["income_tax_brackets"]).each_with_index do |tax_bracket, mrate_index|
        bracket = ::BigDecimal.new(tax_bracket["bracket"], 8) / 100
        marginal_rate = ::BigDecimal.new(tax_bracket["marginal_rate"], 8)

        if mrate_index == target_table["income_tax_brackets"].length - 1
          amount += (adjusted_income - bracket) * marginal_rate
        elsif adjusted_income < target_table["income_tax_brackets"][mrate_index + 1]["bracket"]
          amount += (adjusted_income - bracket) * marginal_rate
          break
        else
          amount+= (target_table["income_tax_brackets"][mrate_index + 1]["bracket"] - bracket) * marginal_rate
        end
      end

      amount
    end

    class << self
      def new_nice_hash
        Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
      end
    end

  end
end
