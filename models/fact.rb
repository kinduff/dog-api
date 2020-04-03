class Fact < ActiveRecord::Base
  def self.get_random(number = 1)
    number = number.to_i if number.respond_to?(:to_i)
    number = 1 if number == 0
    number = 100 if number > 100

   order(Arel.sql('random()')).limit(number)
  end

  def message
    "*Dog Fact ##{self.id}*: #{self.body}\n:dog: :dog: :dog:"
  end
end
