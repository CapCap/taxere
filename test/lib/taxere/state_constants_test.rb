require_relative '../../test_helper.rb'

class TestStateConstants < Minitest::Unit::TestCase
  def test_short_to_full_map
    test_short = 'AL'
    test_long  = 'Alabama'
    assert_equal( test_long, Taxere::StateConstants::SHORT_TO_FULL_MAP[test_short])
  end
end