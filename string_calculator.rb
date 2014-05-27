class StringCalculator
  NegativeNumberError = Class.new(StandardError)

  def initialize

  end

  def add(expression)
    delimiter = ','
    if custom_delimiter?(expression)
      delimiter = expression[2]
      expression = expression[4..-1]
    end
    numbers = expression.split(/(#{delimiter}|\n)/).map {|x| x.to_i}

    negatives = numbers.select {|element| element < 0}
    if negatives.any?
      raise NegativeNumberError.new("negatives not allowed: #{negatives.join(', ')}")
    end

    numbers.inject(0, :+)
  end

  def custom_delimiter?(expression)
    expression.start_with?('//')
  end
end
