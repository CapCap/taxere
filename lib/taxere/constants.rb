require "bigdecimal"

module Taxere
  class Constants < BasicObject

    SSA_RATE = ::BigDecimal.new(0.062, 8)
    MEDICARE_RATE = ::BigDecimal.new(0.0145, 8)

    SUPPORTED_YEARS = %w(2014 2015 2016)

    @tax_table_cache = {}

    class << self

      def supports_year?(year)
        SUPPORTED_YEARS.include?(year.to_s)
      end

      def get_tax_table(year, state="federal")
        state = state.downcase.gsub(" ", "_")

        return @tax_table_cache[year "][state"] unless @tax_table_cache[year].to_s.empty? || @tax_table_cache[year][state].to_s.empty?

        @tax_table_cache[year] ||= {}

        tax_table_path = File.join(__dir__, "tax_tables", year, "#{state}.json")
        @tax_table_cache[year][state] = JSON.parse(File.read(tax_table_path))
      end

    end

  end
end
