class StringCalculator
  NegativeNumberError = Class.new(StandardError)

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
    negatives = negatives(numbers)
    raise_negatives(negatives) if negatives.any?
  end

  def raise_negatives(negatives)
    raise NegativeNumberError.new("negatives not allowed: #{negatives.join(', ')}")
  end

  def negatives(numbers)
    numbers.select { |element| element < 0 }
  end

  def delete_greater_than_1000(numbers)
    numbers.select {|x| x <= 1000}
  end

  def set_expression_and_delimiter(expression)
    if custom_delimiter?(expression)
      split_expression =  expression.split("\n")
      delimiters = get_custom_delimiters(split_expression.first.delete('/'))
      split_expression.shift
      expression = split_expression.join('\n')
    else
      delimiters  = ','
      expression = expression
    end

    return expression, delimiters
  end

  def get_custom_delimiters(delimiters_line)
    delimiters = []
    delimiters_line.gsub(/\[[^\[^\]]+\]/) do |match|
      delimiters << Regexp.escape(match.delete('[').delete(']'))
    end
    delimiters.join('|')
  end


  def sum(numbers)
    numbers.inject(0, :+)
  end
end
