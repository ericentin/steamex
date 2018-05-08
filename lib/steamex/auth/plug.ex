defmodule Steamex.Auth.Plug do
  @moduledoc """
  A Plug for handling the return_to request for a Steam auth attempt.

  If you are using Phoenix, please see `Steamex.Auth.Phoenix`.

  You should mount this plug at the URL you pass as the `return_to` when
  calling `Steamex.Auth.auth_url/2`. If the payload from Steam is validated,
  the user's steamid64 will be put in the session key `:steamex_steamid64`.

  If you need to look up a user in your DB (for instance), you could then
  write a plug to access this session key and find/create a user in your app,
  which you can then put in conn.assigns.

  If validation fails, this plug will return a 403 with an empty body.
  Validation generally should only fail in cases of tampering or Steam being
  down, so this generally should not affect user experience.

  By default, this plug redirects to "/" after a successful authentication,
  but this can be overridden by setting in your config:

  config :steamex, Steamex,
  redirect_to: "/profile/me"

  You can also override this behavior by adding a "redirect_to" query
  parameter to the return_to URL. If auth is successful, this plug will
  redirect to the given path. Non-path values (such as external URLs) will be
  ignored.
  """

  import Plug.Conn

  def init(options \\ []) do
    Keyword.merge([steamex_auth: Steamex.Auth], options)
  end

  def call(conn, options) do
    try do
      conn = fetch_query_params(conn)

      {conn, options[:steamex_auth].validate_payload(conn.query_params)}
    rescue
      _ -> send_resp(conn, 403, "")
    else
      {conn, steamid64} ->
        default_to =
          (Application.get_env(:steamex, Steamex) || [])
          |> Keyword.get(:redirect_to, "/")

          to =
            case conn.query_params["redirect_to"] do
              "//" <> _ -> default_to
              "/" <> rest -> "/" <> rest
              _ -> default_to
            end

            conn
            |> fetch_session
            |> put_session(:steamex_steamid64, steamid64)
            |> put_resp_header("location", to)
            |> send_resp(302, "")
    end
  end
end
