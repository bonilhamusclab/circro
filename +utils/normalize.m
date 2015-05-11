 function normalized = normalize(array, newMin, newMax)
 %function normalized = normalize(array, newMin, newMax)
 %http://stackoverflow.com/questions/10364575/normalization-in-variable-range-x-y-in-matlab
     m = min(array(:));
     range = max(array(:)) - m;
     if(range == 0)
         normalized = array .* ((newMax + newMin) * .5);
         return;
     end
     array = (array - m) / range;

     range2 = newMax - newMin;
     normalized = (array*range2) + newMin;