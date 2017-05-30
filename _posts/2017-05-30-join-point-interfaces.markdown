---
layout: post
title: "Extending ABC compiler to implement Join Point Interfaces in AspectJ"
date: 2017-05-30 12:49:00
tag:
- Java
- Aspect Oriented Programming
projects: true
---
## Overview
Join Point Interfaces is an abstraction which by design supports modular reasoning and independent evolution by decoupling aspects from base code and by providing a modular type-checking algorithm. In this post, I want to share with you how I extended the ABC compiler to implement this new abstraction as part of the AspectJ Programming Language. This work was part of my [master's thesis](/assets/documents/projects/jpi/master_thesis.pdf). [Éric Tanter](https://pleiad.cl/people/etanter) and [Eric Bodden](http://www.bodden.de/) were my advisors, and this was a joint work with them.

## AspectJ in a nutshell
Let's consider the following e-commerce application in which a customer can check out a product by either buying or renting the product.

{% gist 5ed4a4e5c1377b0cc88476aa00c7f7d0 ShoppingSession.java%}

Let's now pretend that we need to implement a new business rule states that, on his/her birthday, the customer is given a 5% discount when checking out a product. To implement this logic, we can implement the **Discount** aspect:

{% gist 5ed4a4e5c1377b0cc88476aa00c7f7d0 Discount.aj %}

We define a pointcut named CheckingOut (Lines 2 - 4), which captures every execution of the ``checkOut`` method (``ShoppingSession.java``, Line 5). This pointcut is defined in terms of two built-in AspectJ pointcuts: ``execution`` and ``args``. The ``execution(* ShoppingSession.checkOut(..))`` means that we want to pick out every join point that is a method execution defined on ``ShoppingSession`` whose name is checkOut regardless of its return type (the ``*`` wildcard) and parameters (the ``..`` wildcard). The ``args(*, pPrice, *, pCustomer)`` means that we want to pick out every join point that has four arguments and also the second argument must be of type ``double`` and the fourth argument must be of type ``Customer``. To implement the birthday discount rule, we define an ``advice`` (Lines 6 - 10) that is associated with the ``pointcut checkingOut`` (Line 2). As it can be noticed, we use an ``around advice`` because we need to take full control over the join point computation: the total amount and customer values are modified accordingly to the discount rule and then the checkOut method is invoked via the call to ``proceed()``.

