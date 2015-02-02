 function normalized = normalize(array, newMin, newMax)
 %function normalized = normalize(array, newMin, newMax)
 %http://stackoverflow.com/questions/10364575/normalization-in-variable-range-x-y-in-matlab
     m = min(array(:));
     range = max(array(:)) - m;
     array = (array - m) / range;

     range2 = newMax - newMin;
     normalized = (array*range2) + newMin;