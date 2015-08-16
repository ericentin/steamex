defmodule Steamex.Auth do
  @moduledoc """
    Functions related to authenticating with the Steam OpenID provider.
  """

  @doc """
    Get the URL you should direct your users to in order to log in.
  """
  def get_auth_url(realm, return_to, options \\ [])
  when is_binary(realm) and is_binary(return_to) and is_list(options) do
    url_params = %{
      "openid.claimed_id": "http://specs.openid.net/auth/2.0/identifier_select",
      "openid.identity": "http://specs.openid.net/auth/2.0/identifier_select",
      "openid.mode": "checkid_setup",
      "openid.ns": "http://specs.openid.net/auth/2.0",
      "openid.ns.ax": "http://openid.net/srv/ax/1.0",
      "openid.ns.sreg": "http://openid.net/extensions/sreg/1.1",
      "openid.realm": realm,
      "openid.return_to": return_to
    }

    "https://steamcommunity.com/openid/login?#{URI.encode_query(url_params)}"
  end
end
