require_relative "string_calculator"
require "test/unit"
 
class TestStringCalculator < Test::Unit::TestCase
 
  def test_add_with_empty_string
    assert_equal 0, StringCalculator.new.add("")
  end
end
