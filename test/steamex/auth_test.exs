defmodule Steamex.AuthTest do
  use ExUnit.Case, async: true

  import Steamex.Auth

  @valid_realm "http://example.com"
  @valid_return_to "http://example.com/users/auth/steam/callback"

  test "get_auth_url" do
    assert get_auth_url(@valid_realm, @valid_return_to) == "https://steamcommunity.com/openid/login?openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.ns.ax=http%3A%2F%2Fopenid.net%2Fsrv%2Fax%2F1.0&openid.ns.sreg=http%3A%2F%2Fopenid.net%2Fextensions%2Fsreg%2F1.1&openid.realm=http%3A%2F%2Fexample.com&openid.return_to=http%3A%2F%2Fexample.com%2Fusers%2Fauth%2Fsteam%2Fcallback"
  end
end
