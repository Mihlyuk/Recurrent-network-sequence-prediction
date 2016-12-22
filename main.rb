require_relative './sequence_prediction.rb'

p 'Enter the number of neurons on the first layer: '
window_size = (gets.chomp).to_i
p 'Enter the number of neurons on the second layer: '
neurons_count = (gets.chomp).to_i
p 'Input error: '
error = gets.chomp.to_f
p 'Input step: '
step = (gets.chomp).to_f
p 'Enter the number of predicted numbers'
predicted_number = (gets.chomp).to_i
p 'Enter the sequence'

sequence = gets.chomp.split(' ').map { |number| number.to_i }

sequence = SequencePrediction.new(window_size, neurons_count, error, step, predicted_number, sequence)
sequence.learning
sequence.show






