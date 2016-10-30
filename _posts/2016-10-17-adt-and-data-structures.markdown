---
layout: post
title: "(Abstract) Data Types and Data Structures"
date: 2016-10-17 20:00:00
tag:
- programming languages
blog: true
---

An Abstract Data Type (ADT) is a collection of values and functions
where one ignores how the values are constructed and how functions are
implemented[^1]. On the other hand, a Data Structure represents the
arrangement of a given set of data in the computer. To put it simply,
ADTs deal with the specifications (semantics), and Data Structures
with the implementation. Let me exemplify this connection by using a
Queue as an example.

[^1]: http://www-compsci.swan.ac.uk/~csulrich/ftp/adt/adt.pdf

A Queue can be defined as a line or sequence of elements awaiting
their turn to be attended to or to proceed[^2]. An element can be added to
the queue by using the `enqueue` operation. An element can be removed
from the queue, when it is eligible to be processed, by using the
`dequeue` operation. And, the `current` operation can be used to get
the element which is eligible to be processed.  As you might notice,
we haven’t even talked about computers yet. Why? This is because when
defining an ADT one ignores implementation details.

[^2]:https://www.google.com/search?q=definition+of+queue&oq=definition+of+queue&aqs=chrome..69i57.3415j0j7&sourceid=chrome&ie=UTF-8

```org-mode
|          Queue Abstract Data Type             |
|------------+----------------------------------|
| Values     | Queue, Element‘                  |
|------------+----------------------------------|
| Operations | enqueue: Queue x Element → Queue |
|            | dequeue: Queue → Queue           |
|            | current: Queue → Element         |
|------------+----------------------------------|
| Arities    | enqueue: 2                       |
|            | dequeue: 1                       |
|            | current: 1                       |
‘: This could be Nat, String, or a generic value.
```

Wanna talk about computers? Great! Let’s pick some Data Structure to implement our Queue ADT. One of the things to consider in the implementation phase is to pick a Data Structure that makes efficient use of the computer’s resources. Array, Single Linked List, Doubly Linked List, among others are natural candidates to implement the Queue ADT. The following is an implementation, written in Erlang, of the Queue ADT using the Array Data Structure:

{% gist 73eea58737720b99417f6bbfa185242a signature.erl %}

First we define an Erlang module by defining its API, which includes
all the operations (`operation_name/arity`) specified in the Queue
Abstract Data Type.This module also includes `empty_queue/0` as a
constant constructor. This operation does not belong to the Queue
Abstract Data Type because when defining an ADT one ignores how values
are constructed. After having the API defined, we can start
implementing the functions.

{% gist 73eea58737720b99417f6bbfa185242a queue_adt.erl %}

I have chosen the Array Data Structure to implement the Queue ADT.  Don’t despair if you are not fluent in Erlang! I have written the same but in Ruby:

{% gist 73eea58737720b99417f6bbfa185242a queue_adt.rb %}

Abstract Data Types can be fully formalized by using many-sorted algebras.  A many-sorted algebra is defined by the triple \\((N, ∑, E)\\); where \\(N\\) is the name of the algebra, \\(∑\\) is the signature of it, and \\(E\\) is the set of equations/operations.  \\(∑\\) is defined by the triple \\((S, OP, A)\\); where \\(S\\) is a set of sorts, \\(OP\\) the set of operations, and \\(A\\) represents the arities of the operations.  If we take a closer look at \\(∑\\) this looks a lot like the concept of an interface in the programming world.  Let’s define \\(∑_{queue}\\) for the Queue ADT:

```
S  = {Queue, Nat}
OP = {enqueue(Queue, Nat) → Queue,
      dequeue(Queue) → Queue,
      current(Queue) → Nat}
A  = {enqueue: 2, dequeue: 1, current: 1}

```

Once the signature is defined, we can define an algebra for it:

```
N = QueueArray
∑ = ∑queue
E = {enqueue(Array, Nat) → Array,
     dequeue(Array) → Array,
     current(Array) → Nat}
```

It is important to note that the signature \\(∑_{queue}\\) can be used to define different type of algebras.

To summarize, Abstract Data Types (ADTs) are defined in terms of operations and its data.  Data Structures are used to implement ADTs in a way that the computer’s resources are used efficiently.  ADTs can be formally defined by using many-sorted algebras.
