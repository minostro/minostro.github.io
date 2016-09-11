---
layout: post
title: "Rebar(3) Templates"
date: 2015-06-13 22:44:00
tag:
- programming-languages
- erlang
blog: true
---

You need to create first an Erlang file (*curlies should be together*):

{% highlight erlang%}
%%% @author   { {author_name} } <{ {author_email} }>
%%% @copyright  { {copyright_year} }  { {author_name} }.
%%% @doc      { {description} }

-module({ {name} }).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

-author('{ {author_name} } <{ {author_email} }>').

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------
-export([start_link/1]).


%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------
-export([init/1, handle_call/3, handle_cast/2, terminate/2, handle_info/2, code_change/3]).


%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------
start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------
init(Args) ->
  {ok, Args}.

handle_call(_Request, _From, State) ->
  {reply, ok, State}.

handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------
{% endhighlight %}

Then, you need to create the template file for `gen_server`:

{% highlight erlang %}
{description, "A basic OTP gen server"}.
{variables, [
    {name, "Name of the gen server"}
]}.

{template, "gen_server.erl", "src/{ {name} }.erl"}.
{% endhighlight %}

These two files have to be placed in `~/.config/rebar3/templates`.  Once they are there, you should see the template available.

{% highlight bash %}
➜rebar3 new
app (built-in): Complete OTP Application structure.
cmake (built-in): Standalone Makefile for building C/C++ in c_src
gen_server (custom): A basic OTP gen server #<-- this one!
lib (built-in): Complete OTP Library application (no processes) structure
plugin (built-in): Rebar3 plugin project structure
release (built-in): OTP Release structure for executable programs
{% endhighlight %}
