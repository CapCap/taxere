require "bigdecimal"
require "taxere/constants"
require "taxere/state_constants"
require "taxere/nice_hash"

module Taxere
  class TaxCalculatorBase

    # this doubles as a response to "/v1/federal/:year/" 
    # and "/v1/state/:state/:year/", and for use internally.
    def get_tax_table(year, state)
      response = self.class.new_nice_hash
      response["success"] = false

      if state.to_s.empty?
        response["reason"] = "Invalid State"
      elsif !::Taxere::Constants.supports_year?(year)
        response["reason"] = "Invalid Year"
      else
        response["success"] = true
        response["data"] = ::Taxere::Constants::get_tax_table(year.to_s, state.downcase.gsub(" ", "_"))
      end

      response
    end

    def get_income_tax_amount(target_table, income)
      deduction_amount = get_deduction_amount(target_table)
      # exemption_amount = 0, there are no exemptions in the tax tables
      adjusted_income = ::BigDecimal.new([income - deduction_amount, 0].max, 8)

      amount = ::BigDecimal.new(0, 8)

      brackets = target_table["income_tax_brackets"];
      last_bracket_i = brackets.length - 1

      # iterate through the brackets, taxing each chunk from lower..upper
      # at that bracket's rate, and sum each chunk's tax amount.
      brackets.each_with_index do |bracket, bracket_i|

        lower = ::BigDecimal.new(bracket["bracket"], 8)
        upper = bracket_i != last_bracket_i ? brackets[bracket_i + 1]["bracket"] - penny : BigDecimal('Infinity')
        marginal_rate = ::BigDecimal.new(bracket["marginal_rate"], 8) / ::BigDecimal.new('100')

        taxable = 0
        if adjusted_income > upper    # max amount from this bracket
          taxable = upper - lower
        elsif adjusted_income > lower # it wasn't bigger than upper, is it between?
          taxable = adjusted_income - lower
        end

        amount += taxable * marginal_rate
      end

      amount
    end

    private

    def penny
      @_penny ||= BigDecimal.new("0.01", 8)
    end

    def get_deduction_amount(target_table)
      target_table["deductions"].each.reduce(0) do |sum, deduction|
        sum += deduction["deduction_amount"].to_i
      end
    end

    class << self
      def new_nice_hash
        Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
      end
    end

  end
end
