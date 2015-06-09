---
layout: post
title:  "Ticket Dispenser"
date:   2015-06-07 10:44:00
categories: [programming-languages, erlang]
---

{% highlight erlang %}
-module(dispenser).
-compile(export_all).

loop(TicketId) ->
  receive
    {From, Ref, take_ticket} ->
      From ! {self(), Ref, TicketId},
      loop(TicketId + 1);
    {reset} ->
      loop(1);
    {stop} ->
      true
  end.

%%%API
start() ->
  spawn(?MODULE, loop, [1]).

take_ticket(Pid) ->
  Ref = make_ref(),
  Pid ! {self(), Ref, take_ticket},
  receive
    {Pid, Ref, Msg} -> Msg
  end.

reset(Pid) ->
  Pid ! {reset}.

stop(Pid) ->
  Pid ! {stop}.
{% endhighlight %}

