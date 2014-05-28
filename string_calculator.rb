class StringCalculator
  NegativeNumberError = Class.new(StandardError)

  def initialize

  end

  def add(expression)
    expression, delimiter = set_expression_and_delimiter(expression)
    numbers = get_numbers(expression, delimiter)
    check_for_negatives(numbers)
    numbers = delete_greater_than_1000(numbers)
    sum(numbers)
  end

  private

  def custom_delimiter?(expression)
    expression.start_with?('//')
  end

  def get_numbers(expression, delimiter)
    expression.split(/(#{delimiter}|\n)/).map {|x| x.to_i}
  end

  def check_for_negatives(numbers)
    negatives = numbers.select {|element| element < 0}
    if negatives.any?
      raise NegativeNumberError.new("negatives not allowed: #{negatives.join(', ')}")
    end
  end

  def delete_greater_than_1000(numbers)
    numbers.select {|x| x <= 1000}
  end

  def set_expression_and_delimiter(expression)
    if custom_delimiter?(expression)
      delimiter  = expression.split("\n").first.gsub('//','')
      expression = expression[delimiter.length+2..-1]
    else
      delimiter  = ','
      expression = expression
    end

    return expression, Regexp.escape(delimiter)
  end

  def sum(numbers)
    numbers.inject(0, :+)
  end
end
