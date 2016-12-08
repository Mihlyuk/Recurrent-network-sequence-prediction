require 'matrix'
require_relative './learning_vector.rb'

class SequencePrediction
  attr_accessor :first_count, :second_count, :error, :step, :max_iteration, :predicted_number,
                :sequence, :learning_vector, :vectors_length, :threshold, :weights_matrix, :ti

  def initialize(first_count, second_count, error, step, max_iteration, predicted_number, sequence)
    @first_count = first_count
    @second_count = second_count
    @error = error
    @step = step
    @max_iteration = max_iteration
    @predicted_number = predicted_number
    @sequence = sequence

    @learning_vectors = []
    @vectors_length = 0

    @threshold = 0
    @weights_w = Matrix.build(@first_count + 1, @second_count) { Random.rand(-1.0..1.0) }
    @weights_v = Matrix.build(@second_count, 1) { Random.rand(-1.0..1.0) }

    make_sequence
  end


  def run
    temp_error = nil
    iteration = 0
    @ti = Matrix[[0] * @second_count]

    loop do
      temp_error = 0
      set_context_neuron(0)

      @learning_vectors.each do |vector|
        x = vector.vector
        p = x * @weights_w - @ti
        y = (p * @weights_v)[0,0] - @threshold
        answer = vector.answer

        delta = y - answer

        @weights_w = @weights_w - (@step * delta * x.transpose * @weights_v.transpose)
        @weights_v = @weights_v - (@step * delta * p.transpose)
      end

      set_context_neuron(0)

      @learning_vectors.each do |vector|
        x = vector.vector
        p = x * @weights_w - @ti
        y = (p * @weights_v)[0, 0] - @threshold

        answer = vector.answer
        delta = y - answer
        set_context_neuron(y)
        temp_error += get_error_degree(delta)
      end

      iteration += 1

      break if temp_error > @error || iteration > @max_iteration
    end

    predict_no
  end

  private

  def make_sequence
    (@sequence.size - @first_count).times do |index|
      vector = LearningVector.new

      vector.set_numbers(@sequence.slice(index, @first_count))
      vector.set_answer(@sequence.at(index + @first_count))
      @learning_vectors << vector
    end

    @vectors_length = @learning_vectors.size
  end

  def predict_no
    vector_x = @learning_vectors[0].vector

    @first_count.times do |index|
      p "Input NO: #{index + 1} #{vector_x[0, index]}"
    end

    @learning_vectors.each_with_index do |vector, index|
      x = vector.vector
      p = x * @weights_w - @ti
      y = (p * @weights_v)[0, 0] - @threshold

      set_context_neuron(y)

      p "Predict No #{index + @first_count + 1}: #{y}"
    end

    @predicted_number.times do |index|
      vector = LearningVector.new

      learning_vector = @learning_vectors.last.vector.row(0).to_a

      vector.set_numbers(learning_vector.slice(1, @first_count + 1))
      vector.set_context_neuron(@learning_vectors.last.vector[0, @first_count])
      @learning_vectors << vector

      x = @learning_vectors.last.vector
      p = x * @weights_w - @ti
      y = (p * @weights_v)[0, 0] - @threshold
      @learning_vectors.last.set_context_neuron(y)
      p "Predict NO #{@vectors_length + @first_count + 1}: #{y}"
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