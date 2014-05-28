require_relative "string_calculator"
require "test/unit"
 
class TestStringCalculator < Test::Unit::TestCase
 
  def test_add_with_empty_string
    assert_equal 0, calc.add("")
  end

  def test_add_only_one_number
    assert_equal 1, calc.add('1')
  end

  def test_add_two_numbers
    assert_equal 3, calc.add("1,2")
  end

  def test_add_unknown_amount_of_numbers
    assert_equal 5, calc.add("1,1,1,1,1")
  end

  def test_new_line_is_a_separator
    assert_equal 6, calc.add("1\n2,3")
  end

  def test_change_to_custom_delimiter
    assert_equal 3, calc.add("//;\n1;2")
  end

  def test_should_throw_exepction_when_negative_number
    assert_raise StringCalculator::NegativeNumberError do
      calc.add("1,-1")
    end
  end

  def test_error_message_should_contain_negative_number
    assert_raise_with_message StringCalculator::NegativeNumberError, 'negatives not allowed: -1' do
      calc.add("1,-1")
    end

    assert_raise_with_message StringCalculator::NegativeNumberError, 'negatives not allowed: -1, -2, -3' do
      calc.add("-1,-2,-3")
    end
  end

  def test_add_ignores_numbers_gt_1000
    assert_equal 1002, calc.add("1000,2")
    assert_equal 2,    calc.add("1001,2")
  end

  def test_custom_delimiters_longer_than_one_char
    assert_equal 4, calc.add("//***\n1***3")
  end

  def test_multiple_delimiters
    assert_equal 6, calc.add("//[*][%]\n1*2%3")
  end

  private

  def calc
    StringCalculator.new
  end
end