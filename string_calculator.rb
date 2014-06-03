class StringCalculator
  NegativeNumberError = Class.new(StandardError)

  def add(expression)
    expression = Expression.new(expression)
    delimiters = Delimiters.new(expression.delimiters_line)
    numbers_line = expression.numbers_line
    numbers = get_numbers(numbers_line, delimiters)
    check_for_negatives(numbers)
    numbers = delete_greater_than_1000(numbers)
    sum(numbers)
  end

  private

  def get_numbers(expression, delimiters)
    expression.split(/(#{delimiters}|\n)/).map {|x| x.to_i}
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


class Delimiters

  def self.custom_delimiters?(expression)
    expression.start_with?('//')
  end

  def initialize(line)
    @line = line
    set_delimiters
  end

  def to_s
    @delimiters.join('|')
  end

  private

  def set_delimiters
    @delimiters = []
    @line.gsub(/\[?[^\[^\]]+\]?/) do |match|
      @delimiters << Regexp.escape(match.delete('[').delete(']'))
    end
    @delimiters = [','] if @delimiters.empty?
  end
end

class Expression

  attr_reader :delimiters_line, :numbers_line

  def initialize(line)
    if Delimiters.custom_delimiters?(line)
      line = line.split("\n")
      @delimiters_line = line.shift.delete('/')
      @numbers_line = line.join("\n")
    else
      @delimiters_line = ''
      @numbers_line = line
    end
  end
end
