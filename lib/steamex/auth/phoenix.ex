defmodule Steamex.Auth.Phoenix do
  @moduledoc """
    Conveniences for integrating with Phoenix.

    In your web.ex:

      def view do
        quote do
          ...
          use Steamex.Auth.Phoenix, :view
          ...
        end
      end

      def router do
        quote do
          ...
          use Steamex.Auth.Phoenix, :router
          ...
        end
      end

    In your router.ex (outside of any scopes, next to your routes):

      steamex_route_auth

    In your views, when you want to include a link to log in:

      steamex_auth_url(@conn)

    If a user successfully authenticates, they will be redirected to "/" and
    `:steamex_steamid64` will be set in their session to their integer steamid64.

    You can also set a different default redirection URL by setting in your config:

      config :steamex, Steamex,
        redirect_to: "/profile/me"

    You can also manually override the redirection URL on a per-link basis by
    calling steamex_auth_url like:

      steamex_auth_url(@conn, redirect_to: "/profile/me")

    The redirect_to parameter will only allow local paths to be specified.

    If you do not need a persistent user, you can just use this session value.

    If you do need a persistent user (i.e. in your DB), you can implement a Plug
    that will either find or create a new user for the steamid64 and assign it
    to conn.assigns for future use.
  """

  defmacro __using__(:router) do
    quote do
      import Steamex.Auth.Phoenix.Router
    end
  end

  defmacro __using__(:view) do
    quote do
      import Steamex.Auth.Phoenix.View
    end
  end
end
