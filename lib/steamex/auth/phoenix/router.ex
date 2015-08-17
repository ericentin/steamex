defmodule Steamex.Auth.Phoenix.Router do
  @moduledoc """
    Router helpers for using Steamex auth with Phoenix.
  """

  @doc """
    Inserts a route for the Steamex auth return_to URL.

    This route (by default) is:

        get "/steamex/return_to", Steamex.Auth.Plug, [], as: :steamex_auth_return_to

    You can customize the return_to URL via the first parameter.

    The plug options can be altered via the second parameter. Please refer to
    `Steamex.Auth.Plug` for available options (if any).

    The router options can be altered via the final parameter. Please note that
    if you change the `:as` option, you must also alter your invocation of the
    `Steamex.Auth.Phoenix.View` helper. In this case it is suggested that you
    add your own view helper that calls the Steamex one with the appropriate
    options.
  """
  @spec steamex_route_auth(String.t, Keyword.t, Keyword.t) :: Macro.t
  defmacro steamex_route_auth(url \\ "/steamex/return_to", steamex_auth_plug_opts \\ [], router_opts \\ []) do
    router_opts = Keyword.merge([as: :steamex_auth_return_to], router_opts)

    quote do
      get unquote(url), Steamex.Auth.Plug, unquote(steamex_auth_plug_opts), unquote(router_opts)
    end
  end
end
