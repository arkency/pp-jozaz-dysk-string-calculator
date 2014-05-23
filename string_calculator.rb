class StringCalculator


  def initialize

  end

  def add(expression)
    return 0 if expression == ''
    numbers = expression.split(/(,|\n)/).map {|x| x.to_i}
    numbers.inject(0, :+)
  end
end
