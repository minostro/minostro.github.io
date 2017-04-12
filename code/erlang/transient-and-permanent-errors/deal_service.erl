-module(deal_service).
-export([get_merchant/1]).

get_merchant(AccountId) ->
  {ok, Account} = deal_service_lib:get_account(AccountId),
  build_merchant(Account).

%%%===================
%%% Private Functions
%%%===================
build_merchant(Account) ->
  MerchantMap = #{
    name => proplists:get_value(name, Account),
    phone => proplists:get_value(phone, Account)
  },
  merchant:build(MerchantMap).
