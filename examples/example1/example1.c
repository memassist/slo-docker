// Example from http://slo.sourceforge.net/dochtml/ch04s03.html

#include <stdio.h>
#include <stdlib.h>

double*
make_vec (int len);

void ex (double *X, double *Y, int len, int N)
{
  int i,j,k;
  for(i=0; i<N; i++) {
    for(j=1; j<len; j++)
      Y[j] = Y[j]*X[i];
    for(k=1; k<len; k+=2)
      Y[k] = (Y[k]+Y[k-1])/2.0;
  }
}

int main(int argc, char** argv)
{
  int len;
  int N=10;
  double *X, *Y;
  double result;
  if (argc!=2) {
    fprintf(stderr, "Usage: %s len\n", argv[0]);
    exit(-1);
  }
  len = atoi(argv[1]);
  X = make_vec (len);
  Y = make_vec (len);

  ex (X,Y,len, N);
  exit(0);
}
