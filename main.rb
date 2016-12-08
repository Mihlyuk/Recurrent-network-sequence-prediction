require_relative './sequence_prediction.rb'

p 'Введите количество нейронов на первом слое: '
# neuron_count_first = gets.chomp
neuron_count_first = 2

p 'Введите количество нейронов на втором слое: '
# neuron_count_second = gets.chomp
neuron_count_second = 4

p 'Введите ошибку: '
# error = gets.chomp
error = 0.0048

p 'Введите шаг: '
# step = gets.chomp
step = 0.000001

p 'Введите максимальное число итераций: '
# max_iteration = gets.chomp
max_iteration = 15

p 'Введите predicted number'
# predicted_number = gets.chomp
predicted_number = 10

p 'Введите последовательность'
# sequence = gets.chomp.split(' ').map { |number| number.to_i }
sequence = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]

sequence = SequencePrediction.new(neuron_count_first, neuron_count_second, error, step, max_iteration, predicted_number, sequence)

sequence.run






