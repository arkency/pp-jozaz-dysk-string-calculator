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

  def test_add_unknown_amount_of_numbers
    assert_equal 5, StringCalculator.new.add("1,1,1,1,1")
  end

  def test_new_line_is_a_separator
    assert_equal 6, StringCalculator.new.add("1\n2,3")
  end

  def test_change_to_custom_delimiter
    assert_equal 3, StringCalculator.new.add("//;\n1;2")
  end

  def test_should_throw_exepction_when_negative_number
    assert_raise StringCalculator::NegativeNumberError.new do
      StringCalculator.new.add("1,-1")
    end
  end

  def test_error_message_should_contain_negative_number
    assert_raise StringCalculator::NegativeNumberError.new('negatives not allowed: -1') do
      StringCalculator.new.add("1,-1")
    end

    assert_raise StringCalculator::NegativeNumberError.new('negatives not allowed: -1, -2, -3') do
      StringCalculator.new.add("-1,-2,-3")
    end
  end
end