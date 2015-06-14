---
layout: post
title:  "Ticket Dispenser (OTP version)"
date:   2015-06-07 10:44:00
categories: [programming-languages, erlang, otp]
---

{% highlight erlang %}
%%% @author   Milton Inostroza <minostro@minostro.com>
%%% @copyright  2015  Milton Inostroza.
%%% @doc

-module(dispenser_worker).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

-author('Milton Inostroza <minostro@minostro.com>').
-record(state, {ticket_id = 0}).
%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------
-export([start_link/0, current_ticket/1, take_ticket/1, reset/1, stop/1,
                       current_ticket/0, take_ticket/0, reset/0, stop/0]).


%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------
-export([init/1, handle_call/3, handle_cast/2, terminate/2, handle_info/2, code_change/3]).


%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------
start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

current_ticket() ->
  gen_server:call(?SERVER, current_ticket).
current_ticket(Pid) ->
  gen_server:call(Pid, current_ticket).

take_ticket() ->
  gen_server:call(?SERVER, take_ticket).
take_ticket(Pid) ->
  gen_server:call(Pid, take_ticket).

reset() ->
  gen_server:cast(?SERVER, reset).
reset(Pid) ->
  gen_server:cast(Pid, reset).

stop() ->
  gen_server:cast(?SERVER, stop).
stop(Pid) ->
  gen_server:cast(Pid, stop).

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------
init(_Args) ->
  {ok, #state{}}.

handle_call(current_ticket, _From, #state{ticket_id=TicketId} = State) ->
  {reply, TicketId, State};
handle_call(take_ticket, _From, #state{ticket_id=TicketId}) ->
  NextTicketId = TicketId + 1,
  {reply, {ok, NextTicketId}, #state{ticket_id=NextTicketId}};
handle_call(_Request, _From, State) ->
  {reply, ok, State}.

handle_cast(reset, _State) ->
  {noreply, #state{}};
handle_cast(stop, State) ->
  {stop, normal, State};
handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.
{% endhighlight %}

