---
layout: post
title:  "Prove divisibility"
date:   2015-06-14 10:44:00
categories: [math, mathematical-induction]
---

Prove by using mathematical induction that \\( 4^{n} + 2\\) is divisibly by \\(3\\).

So, we want to prove that \\( 4^{n} + 2 \overset{?}{=} 3l\\)


Let's multiple first by \\(4 \\)

\\(=> 4 \times 4^{k} + 4 \times 2 \\)

\\(=> 4^{k+1} + 8 \\)

\\(=> 4 \times (4^{k} + 2) - 6 \\)

\\(=> (3 + 1) \times (4^{k} + 2) - 6 \\)

\\(=> 3 \times 4^{k} + 6 + 4^{k} + 2 - 6\\)

\\(=> 3 \times 4^{k} + 4^{k} + 2\\)

\\(=> 4^{k} \times (3 + 1) + 2\\)

\\(=> (4^{k} \times 3) + (4^{k} + 2)\\)

Using our induction hypothesis \\( 4^{n} + 2 \overset{?}{=} 3l\\)

\\(=> (4^{k} \times 3) + 3l\\)

\\(=> 3 \times (4^{k} + l)\\)

So, we can conclude that \\( 4^{n} + 2\\) is divisible by \\(3\\).