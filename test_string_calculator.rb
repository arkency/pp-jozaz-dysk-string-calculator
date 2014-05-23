require_relative "string_calculator"
require "test/unit"
 
class TestStringCalculator < Test::Unit::TestCase
 
  def test_add_with_empty_string
    assert_equal 0, StringCalculator.new.add("")
  end

  def test_add_only_one_number
    assert_equal 1, StringCalculator.new.add('1')
  end

  def test_add_two_numbers
    assert_equal 3, StringCalculator.new.add("1,2")
  end

  def test_add_unknow_amount_of_numbers
    assert_equal 5, StringCalculator.new.add("1,1,1,1,1")
  end
end
