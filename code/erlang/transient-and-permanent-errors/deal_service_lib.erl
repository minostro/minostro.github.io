-module(deal_service_lib).
-export([get_account/1]).

get_account(AccountId) ->
  talk_to_deal_service(AccountId).

%% This function could return:
%% 1.- A salesforce account, or
%% 2.- An error, or
%% 3.- An exception
talk_to_deal_service(_AccountId) ->
  case is_down() of
    true -> {error, {503, service_unavailable}};
    false -> {ok, [{name, "My Company Co."}, {phone, "312 307 0031"}]}
  end.

is_down() ->
  Options = [false, true],
  lists:nth(rand:uniform(2), Options).
