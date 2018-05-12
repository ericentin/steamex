defmodule Steamex.Auth.Phoenix.View do
  @moduledoc """
    View helpers for using Steamex auth with Phoenix.
  """

  @doc """
    Returns the URL that the user must visit to begin the Steam authentication process.

    You can pass the option `:redirect_to` in order to redirect to a page other
    than the default upon successful authentication. This option allows any path
    to be specified, but this value will be validated to ensure it is a local
    path upon successful authentication.

    You can override the Steamex auth return_to helper name (by default, it is
    `:steamex_auth_return_to_url`) by passing the option
    `:return_to_helper`. If you have used the default options
    for `steamex_route_auth`, you do not need to set this option.
  """
  @spec steamex_auth_url(Plug.Conn.t(), Keyword.t()) :: String.t()
  def steamex_auth_url(conn, options \\ []) do
    steamex_auth_url(conn, options, Phoenix.Controller)
  end

  @doc false
  def steamex_auth_url(conn, options, phoenix_controller) do
    options = Keyword.merge([return_to_helper: :steamex_auth_return_to_url], options)

    helpers = Module.concat(phoenix_controller.router_module(conn), Helpers)

    realm = helpers.url(conn)

    return_to = apply(helpers, options[:return_to_helper], [conn, []])

    return_to =
      if redirect_to = options[:redirect_to] do
        return_to <> "?" <> URI.encode_query(%{redirect_to: redirect_to})
      else
        return_to
      end

    Steamex.Auth.auth_url(realm, return_to)
  end
end
