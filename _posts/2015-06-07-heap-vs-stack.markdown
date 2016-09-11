---
layout: post
title: "Heap vs Stack"
date: 2015-06-07 10:44:00
tag: programming-languages
blog: true
---

{% highlight c linenos=table %}
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
  //array will be allocated on the stack, thus
  //it won't live after the stack is reclaimed.
  int array[10];
  return fill_array(array, 10);
}

int* righ_foo() {
  //array will be allocated on the heap, thus
  //it will live after the stack is reclaimed.
  int* array = malloc(10 * sizeof(int));
  return fill_array(array, 10);
}


int main(int args, char *argv[]) {
  int* my_array = foo();
  int* my_righ_array = righ_foo();

  printf("value: %i\n", my_array[0]); //won't output 1
  printf("value: %i\n", my_array[0]); //won't output 1

  printf("value: %i\n", my_righ_array[0]); //will output 1
  printf("value: %i\n", my_righ_array[0]); //will output 1

  return 0;
}
{% endhighlight %}

The output when running this program:

{% highlight bash %}
➜ ./a.out
value: 40
value: 1425650832
value: 1
value: 1
{% endhighlight %}
