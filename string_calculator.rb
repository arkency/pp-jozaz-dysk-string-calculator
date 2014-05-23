class StringCalculator


  def initialize
  end

  def add(expression)
    return 0 if expression == ''
    return expression.to_i
  end
end
