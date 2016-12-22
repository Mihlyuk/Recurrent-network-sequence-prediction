Recurrent network - sequence prediction
============
Progress:
------

Specifies the numerical sequence for which you want to predict the n-e number of items. Also, the following parameters are specified:
- The size of the window
- The number of hidden layer elements
- The maximum permissible error
- N, the number of elements to predict
- number of iterations

Elman neural network has 3 matrix of weighting coefficients:
1. Between input neurons and hidden layer, then W
2. Between contextual neurons and hidden layer, then U
3. Between the hidden layer and output, then W1 

The next step is to initialize the values ​​of the weights. Each weight is given a random value [-1, 1].
 
Result of work
-------

**Периодическая последовательность**

_Параметры сети:_ 
 - window_size = 4; 
 - neurons_size = 8; 
 - error = 0.0001; 
 - step = 0.000001; 
 - Последовательность: (15,-13,6,47,15,-13,6,47,15,-13,6,47), 15, -13, 6, 47, ... 
 - Выборка для обучения: первых 12 чисел последовательности;
 - Количество совершенных итераций: 56599;

**Факториал**	

_Параметры сети:_ 
 - window_size = 3; 
 - neurons_size = 6; 
 - error = 0.05; 
 - step = 0.000001;
 - Последовательность: (1, 2, 6, 24, 120, 720, 5040), 40320, 362880, 3628800
 - Выборка для обучения: первых 7 чисел последовательности;
 - Количество совершенных итераций: 272688


Example
-------------
![demo](example.gif)
