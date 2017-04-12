-module(entry_point).
-export([perform/2]).

-record(task, {lambda,
	       error_handler,
	       error,
	       stacktrace,
	       remaining_attempts = 6}).

perform(Lambda, ErrorHandler) ->
  Task = #task{
    lambda = Lambda,
    error_handler = ErrorHandler
  },
  perform_with_retry(Task).

%%%===================
%%% Private Functions
%%%===================
perform_with_retry(#task{remaining_attempts = 1} = Task) ->
  notify_of_error(Task);
perform_with_retry(#task{lambda = Lambda} = Task) ->
  try Lambda() of
      _ -> log("Task succeeded")
  catch
    error:Error ->
      retry(Task#task{
	      error = Error,
	      stacktrace = erlang:get_stacktrace()})
  end.

retry(#task{remaining_attempts = 0} = Task) ->
  notify_of_error(Task);
retry(#task{remaining_attempts = RemainingAttempts} = Task) ->
  log("Retrying Task"),
  delayed_job:schedule(
    fun() ->
	perform_with_retry(
	  Task#task{
	    remaining_attempts = RemainingAttempts - 1
	  }
	)
    end
   ).

notify_of_error(#task{error_handler = Handler, error = Error, stacktrace = Stacktrace}) ->
  Handler(Error, Stacktrace).

log(Msg) ->
  erlang:display(Msg).
