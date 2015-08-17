defmodule Steamex.Auth.Phoenix.ViewTest do
  use ExUnit.Case, async: true

  import Steamex.Auth.Phoenix.View

  defmodule RouterModuleTest.Helpers do
    def url(%Plug.Conn{}), do: "http://example.com"

    def steamex_auth_return_to_url(%Plug.Conn{}, []), do: "http://example.com/steamex/return_to"

    def foobar_url(%Plug.Conn{}, []), do: "http://example.com/foobar"
  end

  defmodule PhoenixControllerTest do
    def router_module(%Plug.Conn{}), do: RouterModuleTest
  end

  test "steamex_auth_url" do
    assert steamex_auth_url(%Plug.Conn{}, [], PhoenixControllerTest) == "https://steamcommunity.com/openid/login?openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.realm=http%3A%2F%2Fexample.com&openid.return_to=http%3A%2F%2Fexample.com%2Fsteamex%2Freturn_to"
  end

  test "steamex_auth_url override return_to_helper" do
    assert steamex_auth_url(%Plug.Conn{}, [return_to_helper: :foobar_url], PhoenixControllerTest) == "https://steamcommunity.com/openid/login?openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.realm=http%3A%2F%2Fexample.com&openid.return_to=http%3A%2F%2Fexample.com%2Ffoobar"
  end

  test "steamex_auth_url redirect_to" do
    assert steamex_auth_url(%Plug.Conn{}, [redirect_to: "/foobar"], PhoenixControllerTest) == "https://steamcommunity.com/openid/login?openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.realm=http%3A%2F%2Fexample.com&openid.return_to=http%3A%2F%2Fexample.com%2Fsteamex%2Freturn_to%3Fredirect_to%3D%252Ffoobar"
  end
end
