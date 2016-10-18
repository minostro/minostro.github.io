-module(queue_adt).
-export([empty_queue/0,
	 enqueue/2,
	 dequeue/1,
	 current/1]).

empty_queue() ->
  [].

enqueue(Queue, Element) ->
  [Element | Queue].

dequeue(Queue) ->
  lists:droplast(Queue).

current(Queue) ->
  lists:last(Queue).

