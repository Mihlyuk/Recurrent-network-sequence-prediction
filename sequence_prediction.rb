require 'matrix'
require_relative './learning_vector.rb'

class SequencePrediction
  attr_accessor :window_size, :neurons_count, :error, :step, :predicted_number,
                :sequence, :learning_vector, :vectors_length, :threshold, :weights_matrix, :ti

  def initialize(first_count, second_count, error, step, predicted_number, sequence)
    @window_size = first_count
    @neurons_count = second_count
    @error = error
    @step = step
    @predicted_number = predicted_number
    @sequence = sequence

    @learning_vectors = []

    @weights_w = Matrix.build(@window_size + 1, @neurons_count) { Random.rand(-0.1..0.1) }
    @weights_v = Matrix.build(@neurons_count, 1) { Random.rand(-0.1..0.1) }

    create_learning_vectors
  end

  def learning
    iteration = 0

    loop do
      temp_error = 0
      set_context_neuron(0)

      @learning_vectors.each do |vector|
        x = vector.vector
        s = x * @weights_w
        p_a = activation(s)
        p_ap = activation_p(s)
        y = s * @weights_v

        answer = vector.answer
        delta = y[0, 0] - answer
        set_context_neuron(y[0,0])

        @weights_w = @weights_w - (@step * delta * x.t * p_ap * @weights_v * p_a)
        @weights_v = @weights_v - (@step * delta * p_a.t)
      end

      set_context_neuron(0)

      @learning_vectors.each do |vector|
        x = vector.vector
        p = x * @weights_w
        y = (p * @weights_v)[0, 0]

        answer = vector.answer
        delta = y - answer

        set_context_neuron(y)
        temp_error += get_error_degree(delta)
      end

      iteration += 1
      p "iteration: #{iteration} error: #{temp_error}"
      break if temp_error <= @error
    end
  end

  def show
    answer = []
    answer.concat(@sequence)
    answer << ':'

    @predicted_number.times do
      vector = LearningVector.new

      learning_vector = @learning_vectors.last.vector.row(0).to_a

      vector.set_numbers(learning_vector.slice(1, @window_size + 1))
      vector.set_context_neuron(@learning_vectors.last.vector[0, @window_size])
      @learning_vectors << vector

      x = @learning_vectors.last.vector
      p = x * @weights_w
      y = (p * @weights_v)[0, 0]
      @learning_vectors.last.set_context_neuron(y)

      answer << y.to_f.round(2)
    end

    p answer.join(' ')
  end

  private

  def activation(vector)
    vector.map { |number| Math.log(number + Math.sqrt(number ** 2 + 1)) }
  end

  def activation_p(vector)
    vector.map { |number| Math.log(1 / Math.sqrt(number ** 2 + 1)) }
  end

  def create_learning_vectors
    (@sequence.size - @window_size).times do |index|
      vector = LearningVector.new

      vector.set_numbers(@sequence.slice(index, @window_size))
      vector.set_answer(@sequence.at(index + @window_size))
      @learning_vectors << vector
    end
  end

  def get_error_degree(delta)
    1.0 / 2 * (delta ** 2)
  end

  def set_context_neuron(neuron)
    @learning_vectors.each do |vector|
      vector.set_context_neuron(neuron)
    end
  end

end