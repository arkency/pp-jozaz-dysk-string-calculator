class StringCalculator
  NegativeNumberError = Class.new(StandardError)

  def initialize

  end

  def add(expression)
    expression, delimiter = set_expression_and_delimiter(expression)
    numbers = get_numbers(expression, delimiter)
    check_for_negatives(numbers)
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

  def set_expression_and_delimiter(expression)
    if custom_delimiter?(expression)
      delimiter  = expression[2]
      expression = expression[4..-1]
    else
      delimiter  = ','
      expression = expression
    end

    return expression, delimiter
  end

  def sum(numbers)
    numbers.inject(0, :+)
  end
end
