-module(merchant).
-export([build/1]).
-record(merchant, {name, phone}).

build(MerchantMap) ->
  Merchant = #merchant{
    name = maps:get(name, MerchantMap),
    phone = maps:get(phone, MerchantMap)
  },
  case valid(Merchant) of
    true ->
      {ok, Merchant};
    Reason ->
      {error, Reason}
  end.

valid(#merchant{name = undefined}) ->
  name_is_missing;
valid(#merchant{phone = undefined}) ->
  phone_is_missing;
valid(#merchant{}) ->
  true.
