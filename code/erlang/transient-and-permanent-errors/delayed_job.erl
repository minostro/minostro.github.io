-module(delayed_job).
-export([start/0,
	 schedule/1]).

start() ->
  Pid = spawn(fun server_loop/0),
  register(delayed_job, Pid).

schedule(Lambda) ->
  delayed_job ! {schedule, Lambda}.

%%%==================
%%% Private Functions
%%%==================
server_loop() ->
  receive
    {schedule, Lambda} ->
      spawn(fun() -> worker_loop(Lambda) end),
      server_loop()
  end.

worker_loop(Lambda) ->
  receive
    _ ->
      ok
  after 50 ->
      Lambda()
  end.
