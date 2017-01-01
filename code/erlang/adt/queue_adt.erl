-module(queue_adt).
-export([empty_queue/0,
	 enqueue/2,
	 dequeue/1,
	 current/1]).

empty_queue() ->
  {[], []}.

enqueue({[Value], []}, Element) ->
  {[Element], [Value]};
enqueue({In, Out}, Element) ->
  {[Element | In], Out}.

dequeue({[], []}) ->
  {error, queue_empty};
dequeue({[_Head], []}) ->
  {[], []};
dequeue({In, [_Head | [Next | Rest]]}) ->
  {In, [Next | Rest]};
dequeue({In, [_Head | _Rest]}) ->
  {[], lists:reverse(In)}.

current({[], []}) ->
  {error, queue_empty};
current({[Current], []}) ->
  Current;
current({_In, [Current | _Rest]}) ->
  Current.
