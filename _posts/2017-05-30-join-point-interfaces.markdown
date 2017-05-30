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
