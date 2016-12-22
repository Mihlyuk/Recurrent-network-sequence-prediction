require_relative './sequence_prediction.rb'

p 'Введите количество нейронов на первом слое: '
window_size = (gets.chomp).to_i
# window_size = 3

p 'Введите количество нейронов на втором слое: '
neurons_count = (gets.chomp).to_i
# neurons_count = 6

p 'Введите ошибку: '
error = gets.chomp.to_f
# error = 1.6

p 'Введите шаг: '
step = (gets.chomp).to_f
# step = 0.000001

p 'Введите количество предсказанных чисел'
predicted_number = (gets.chomp).to_i
# predicted_number = 10

p 'Введите последовательность'
sequence = gets.chomp.split(' ').map { |number| number.to_i }
# sequence = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225]

sequence = SequencePrediction.new(window_size, neurons_count, error, step, predicted_number, sequence)

sequence.learning
sequence.show






