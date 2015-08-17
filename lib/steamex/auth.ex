defmodule Steamex.Auth do
  @moduledoc """
    Functions related to authenticating with the Steam OpenID provider.
  """

  @steam_login_url_base "https://steamcommunity.com/openid/login"

  @doc """
    Returns the URL you should direct your users to in order to log in.

    `realm` should be set to your base URL, i.e. "http://example.com".

    `return_to` is the URL that Steam will redirect to after a successful auth.
    If you use `Steamex.Auth.Phoenix`, this is `realm <> "/steamex/return_to"`
    by default.
  """
  @spec auth_url(String.t, String.t) :: String.t
  def auth_url(realm, return_to) when is_binary(realm) and is_binary(return_to) do
    @steam_login_url_base <> "?" <> URI.encode_query %{
      "openid.claimed_id" => "http://specs.openid.net/auth/2.0/identifier_select",
      "openid.identity" => "http://specs.openid.net/auth/2.0/identifier_select",
      "openid.mode" => "checkid_setup",
      "openid.ns" => "http://specs.openid.net/auth/2.0",
      "openid.realm" => realm,
      "openid.return_to" => return_to
    }
  end

  @doc """
    Validate a "return_to" payload from Steam.

    You probably want to use `Steamex.Auth.Plug`/`Steamex.Auth.Phoenix`
    to handle this for you, but it's here in case you want to validate payloads
    manually.

    This function will raise an exception if validation fails, or return the
    user's Steam ID as an integer if it succeeds.
  """
  @spec validate_payload(map, atom) :: integer
  def validate_payload(payload, httpoison \\ HTTPoison) do
    signed = Dict.fetch!(payload, "openid.signed")

    signed_param_names = String.split(signed, ",") |> Enum.map(&"openid.#{&1}")

    params =
      Dict.take(payload, signed_param_names)
      |> Dict.merge %{
        "openid.assoc_handle" => Dict.fetch!(payload, "openid.assoc_handle"),
        "openid.sig" => Dict.fetch!(payload, "openid.sig"),
        "openid.ns" => Dict.fetch!(payload, "openid.ns"),
        "openid.mode" => "check_authentication"
      }

    Application.ensure_all_started(:httpoison)

    %HTTPoison.Response{status_code: 200, body: body} =
      httpoison.post! @steam_login_url_base, URI.encode_query(params), [
        {"Content-Type", "application/x-www-form-urlencoded"}
      ]

    unless String.contains? body, "is_valid:true" do
      raise "Invalid auth attempt: #{inspect payload}"
    end

    "http://steamcommunity.com/openid/id/" <> steamid64_str = payload["openid.identity"]

    {steamid64, ""} = Integer.parse(steamid64_str)

    steamid64
  end
end
