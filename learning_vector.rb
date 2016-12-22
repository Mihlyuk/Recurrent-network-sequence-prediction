require 'matrix'

class LearningVector
  attr_accessor :vector, :answer

  def initialize
    @numbers = []
    @vector = []
  end

  def set_numbers(numbers)
    @numbers = numbers
    @numbers << 0

    @vector = Matrix[numbers]
  end

  def set_context_neuron(neuron)
    @vector.send(:[]=, 0, @vector.column_count - 1, neuron)
  end

  def set_answer(answer)
    @answer = answer
  end
end
