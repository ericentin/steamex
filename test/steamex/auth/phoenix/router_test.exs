defmodule Steamex.Auth.Phoenix.RouterTest do
  use ExUnit.Case, async: true

  import Steamex.Auth.Phoenix.Router

  test "steamex_route_auth defaults" do
    assert {:get, [],
            [
              "/steamex/return_to",
              {:__aliases__, [alias: false, counter: _], [:Steamex, :Auth, :Plug]},
              [],
              [as: :steamex_auth_return_to]
            ]} = Macro.expand_once(quote(do: steamex_route_auth), __ENV__)
  end

  test "steamex_route_auth non-defaults" do
    assert {:get, [],
            [
              "/foobar",
              {:__aliases__, [alias: false, counter: _], [:Steamex, :Auth, :Plug]},
              [:test],
              [as: :foobar]
            ]} =
             Macro.expand_once(
               quote(do: steamex_route_auth("/foobar", [:test], as: :foobar)),
               __ENV__
             )
  end
end
