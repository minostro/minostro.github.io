#include <stdio.h>
#include <stdlib.h>

int* fill_array(int* array, int n) {
  int i;
  for(int i=0; i<n; i=i+1){
    array[i] = i+1;
  }
  return array;
}


int* foo() {
  //array will be allocated on the stack, thus it will *NOT*
  //survive stack-frame livespan.
  int array[10];
  return fill_array(array, 10);
}

int* righ_foo() {
  //array will be allocated on the heap, thus it will
  //survive stack-frame livespan.
  int* array = malloc(10 * sizeof(int));
  return fill_array(array, 10);
}


int main(int args, char *argv[]) {
  int* my_array = foo();
  int* my_righ_array = righ_foo();

  printf("value: %i\n", my_array[0]);
  printf("value: %i\n", my_array[0]);

  printf("value: %i\n", my_righ_array[0]);
  printf("value: %i\n", my_righ_array[0]);

  return 0;
}