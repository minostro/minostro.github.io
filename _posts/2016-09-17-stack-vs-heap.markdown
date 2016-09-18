---
layout: post
title: "Stack vs Heap"
date: 2016-09-17 21:05:00
tag:
- programming languages
- operating systems
blog: true
---
Stack and Heap are regions of the memory where values are
stored. Values stored in the Stack will available until the current
context of execution (function execution) finishes.  On the other
hand, values stored in the Heap will be available until the program
execution finishes or when the programmer say so.

Let us consider the following [program](https://gist.githubusercontent.com/minostro/b0d6456e8a888ddbc495536590bdbb06/raw/2d521298cb88bf9f6d7e1bd52c20fe574a8c39b6/store_variable_in_the_stack.c) in
Language C.  The program first asks the user to enter the size of the
array (`array_size`, **Line 13**), and then initializes the array (call to
the `initialize_array` function, **Line 16**) with consecutive numbers starting
from `1` to `array_size`.

{% gist b0d6456e8a888ddbc495536590bdbb06 %}

Let us pretend now, that the user enters `7` as `array_size`.  Then our
program will create an array (`my_array`) of size `7` with values
`[1, 2, 3, 4, 5, 6, 7]` in it.  Could you tell what would be the series
printed by our program when executing **Line 17**?  Intuitively, one might
think that the printed series of values would be `1, 2, 3, 4, 5, 6, 7`,
but the truth is that we cannot tell for sure what the values will be.
The following is the output when running the program:

The output when running this program:

{% highlight bash %}
Enter the array size:
7
value: 1
value: 2
value: 3
value: 4
value: 16
value: 48
value: 1493028960
{% endhighlight %}

In order to understand why this happen, we need to understand the
lifetime of a value throughout the program execution.  Here is when
the difference between Stack and Heap become important.  Have you ever
heard of `local` variables or `global/static` variables?  Local variables
are meant to live in the current context of execution (function/method
execution), whereas global/static variables are meant to live
throughout the program execution.  Following this definition, it is
fair to think that all the values stored in the Stack are temporary
values: the memory region where these values live will be freed up
(destroyed) as soon as the current context of execution is not active
anymore.  On the other hand, all the values stored in the Heap are
permanent values: the memory region where these values live will be
freed up as soon as the program execution finishes or when the
programmer say so.

Based on this definition, when our program is executing **Line 5**, the
array that was defined in **Line 16** is no longer available.  `my_array`
was defined within the method execution, thus, by default, it lives
in the Stack.  This means, that as soon as initialize_array finishes,
the system will free up the portion of the memory where the values of
my_array live.  Pretty cool, uh?  At this point, there are two
possible solutions to fix our program:

1. Delete the `initialize_array` function and move its code into the main
function, or
2. Keep the code as is, but put `my_array` in the Heap.

Option 1 is not an acceptable solution (I’ll let the reader to
determine why), so I will explain option 2.  Some programming
languages, like Language C, allow programmers to choose which store to
use for a particular value.  In this case, we want to store `my_array`
in the Heap, so when initialize_array finishes the main function can
still access the all the values that belong to `my_array`.

{% gist 654da94d1495f3b4e52739f9cc35ad1b %}

As you can see in **Line 5**, our [program](https://gist.githubusercontent.com/minostro/654da94d1495f3b4e52739f9cc35ad1b/raw/be0fd27a82f6f76f67f2e779f4277b09ef8cabe0/store_variable_in_the_heap.c) is
calling `malloc` to allocate `my_array` in the Heap.  In this way, the
main function can have access to the values of the array.  The
following is the output of this new program:

{% highlight bash %}
Enter the array size:
7
value: 1
value: 2
value: 3
value: 4
value: 5
value: 6
value: 7
{% endhighlight %}

Nowadays, In modern programming languages (Java, Ruby, among others),
the practice of allocating memory is not allowed anymore and it is
called unsafe for a reason. You might think about the problems that
can occur if you try to access a value that was already deleted (freed
up) from the memory.

Open Questions
------

This post is getting longer than I thought.  I think there are still
some topics that I would like to talk about:

* When the heap and stack are created?
* Can the Stack and Heap grow?
* How a process is represented by the OS.
* What would happen with threads?
* What happens with the memory afterwards?
