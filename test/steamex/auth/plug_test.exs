defmodule Steamex.Auth.PlugTest do
  use ExUnit.Case, async: true

  use Plug.Test

  defmodule FailAuth do
    def validate_payload(_) do
      raise "fail"
    end
  end

  @fail_opts Steamex.Auth.Plug.init steamex_auth: FailAuth

  test "fails" do
    conn = conn(:get, "/steamex/return_to")

    conn = Steamex.Auth.Plug.call(conn, @fail_opts)

    assert conn.state == :sent
    assert conn.status == 403
    assert conn.resp_body == ""
  end

  defmodule SuccessAuth do
    def validate_payload(_) do
      123
    end
  end

  @success_opts Steamex.Auth.Plug.init steamex_auth: SuccessAuth

  test "success" do
    assert_success "/"
  end

  @async false
  test "success with config override redirect_to" do
    try do
      Application.put_env(:steamex, Steamex, redirect_to: "/foobar")

      assert_success "/foobar"
    after
      Application.delete_env(:steamex, Steamex)
    end
  end

  test "success with query param override redirect_to" do
    assert_success "/herpderp", "/steamex/return_to?redirect_to=/herpderp"
  end

  test "query param override redirect_to does not accept protocol-relative URLs" do
    assert_success "/", "/steamex/return_to?redirect_to=//google.com"
  end

  test "query param override redirect_to does not accept protocol-relative URLs with extra slashes" do
    assert_success "/", "/steamex/return_to?redirect_to=///google.com"
  end

  test "query param override redirect_to does not accept absolute URLs" do
    assert_success "/", "/steamex/return_to?redirect_to=http://google.com"
  end

  defp assert_success(redirect_to, url \\ "/steamex/return_to") do
    conn =
      conn(:get, url)
      |> add_ets_session
      |> Steamex.Auth.Plug.call(@success_opts)

    assert conn.state == :sent
    assert conn.status == 302
    assert conn.resp_body == ""
    assert {"location", redirect_to} in conn.resp_headers

    assert get_session(conn, :steamex_steamid64) == 123
  end

  defp add_ets_session(conn) do
    :ets.new(:session, [:named_table, :public, read_concurrency: true])
    opts = Plug.Session.init(store: Plug.Session.ETS, key: "sid", table: :session)
    Plug.Session.call(conn, opts) |> fetch_session
  end
end
