// Example from http://slo.sourceforge.net/dochtml/ch04s03.html

#include <stdio.h>
#include <stdlib.h>

double*
make_vec (int len)
{
  double* result = (double*)malloc(sizeof(double)*len);
  int i;
  for(i=0; i<len; i++) {
    result[i] = i;
  }
  return result;
}
