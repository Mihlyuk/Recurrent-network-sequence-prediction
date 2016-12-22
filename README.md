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
**The Fibonacci sequence**

_Network settings:_
 - window_size = 2;
 - neurons_size = 4;
 - error = 0.0048;
 - step = 0.00001;
 - Sequence (0, 1, 1, 2, 3, 5, 8, 13, 21, 34), 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946
 - The sample for the study: the first 10 numbers of the sequence;
 - The number of iterations performed: 33412;

Example
-------------
![demo](example.gif)
