#include <stdio.h>

int* initialize_array(int n) {
  int array[n];
  for(int i=0; i<n; i=i+1){
    array[i] = i+1;
  }
  return array;
}

int main(int args, char *argv[]) {
  int array_size;
  printf("Enter the array size:\n");
  scanf("%d", &array_size);

  int* my_array = initialize_array(array_size);

  for(int i=0; i<array_size; i=i+1){
    printf("value: %i\n", my_array[i]);
  }
  return 0;
}
