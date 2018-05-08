defmodule Steamex.AuthTest do
  use ExUnit.Case, async: true

  import Steamex.Auth

  @valid_realm "http://example.com"
  @valid_return_to "http://example.com/users/auth/steam/callback"

  test "auth_url" do
    assert auth_url(@valid_realm, @valid_return_to) == "https://steamcommunity.com/openid/login?openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.realm=http%3A%2F%2Fexample.com&openid.return_to=http%3A%2F%2Fexample.com%2Fusers%2Fauth%2Fsteam%2Fcallback"
  end

  @payload %{
    "openid.assoc_handle" => "1234567890",
    "openid.claimed_id" => "https://steamcommunity.com/openid/id/76561197961358433",
    "openid.identity" => "https://steamcommunity.com/openid/id/76561197961358433",
    "openid.mode" => "id_res",
    "openid.ns" => "http://specs.openid.net/auth/2.0",
    "openid.op_endpoint" => "https://steamcommunity.com/openid/login",
    "openid.response_nonce" => "2015-08-17T00:46:03ZrUXDT9sw/Qx8yxq2VR+76wkBXAw=",
    "openid.return_to" => "http://example.com/callback",
    "openid.sig" => "uj0iEOi1A6PxjFAEfapOhArZOFk=",
    "openid.signed" => "signed,op_endpoint,claimed_id,identity,return_to,response_nonce,assoc_handle"
  }

  defmodule FailureHTTPoison do
    def post!(url, params, headers) do
      assert url == "https://steamcommunity.com/openid/login"
      assert params == "openid.assoc_handle=1234567890&openid.claimed_id=https%3A%2F%2Fsteamcommunity.com%2Fopenid%2Fid%2F76561197961358433&openid.identity=https%3A%2F%2Fsteamcommunity.com%2Fopenid%2Fid%2F76561197961358433&openid.mode=check_authentication&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.op_endpoint=https%3A%2F%2Fsteamcommunity.com%2Fopenid%2Flogin&openid.response_nonce=2015-08-17T00%3A46%3A03ZrUXDT9sw%2FQx8yxq2VR%2B76wkBXAw%3D&openid.return_to=http%3A%2F%2Fexample.com%2Fcallback&openid.sig=uj0iEOi1A6PxjFAEfapOhArZOFk%3D&openid.signed=signed%2Cop_endpoint%2Cclaimed_id%2Cidentity%2Creturn_to%2Cresponse_nonce%2Cassoc_handle"
      assert headers == [{"Content-Type", "application/x-www-form-urlencoded"}]

      %HTTPoison.Response{body: "ns:http://specs.openid.net/auth/2.0\nis_valid:false\n", status_code: 200}
    end
  end

  test "validate_payload failure" do
    assert_raise RuntimeError, "Invalid auth attempt: %{\"openid.assoc_handle\" => \"1234567890\", \"openid.claimed_id\" => \"https://steamcommunity.com/openid/id/76561197961358433\", \"openid.identity\" => \"https://steamcommunity.com/openid/id/76561197961358433\", \"openid.mode\" => \"id_res\", \"openid.ns\" => \"http://specs.openid.net/auth/2.0\", \"openid.op_endpoint\" => \"https://steamcommunity.com/openid/login\", \"openid.response_nonce\" => \"2015-08-17T00:46:03ZrUXDT9sw/Qx8yxq2VR+76wkBXAw=\", \"openid.return_to\" => \"http://example.com/callback\", \"openid.sig\" => \"uj0iEOi1A6PxjFAEfapOhArZOFk=\", \"openid.signed\" => \"signed,op_endpoint,claimed_id,identity,return_to,response_nonce,assoc_handle\"}", fn ->
      validate_payload(@payload, FailureHTTPoison)
    end
  end

  defmodule SuccessHTTPoison do
    def post!(url, params, headers) do
      assert url == "https://steamcommunity.com/openid/login"
      assert params == "openid.assoc_handle=1234567890&openid.claimed_id=https%3A%2F%2Fsteamcommunity.com%2Fopenid%2Fid%2F76561197961358433&openid.identity=https%3A%2F%2Fsteamcommunity.com%2Fopenid%2Fid%2F76561197961358433&openid.mode=check_authentication&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.op_endpoint=https%3A%2F%2Fsteamcommunity.com%2Fopenid%2Flogin&openid.response_nonce=2015-08-17T00%3A46%3A03ZrUXDT9sw%2FQx8yxq2VR%2B76wkBXAw%3D&openid.return_to=http%3A%2F%2Fexample.com%2Fcallback&openid.sig=uj0iEOi1A6PxjFAEfapOhArZOFk%3D&openid.signed=signed%2Cop_endpoint%2Cclaimed_id%2Cidentity%2Creturn_to%2Cresponse_nonce%2Cassoc_handle"
      assert headers == [{"Content-Type", "application/x-www-form-urlencoded"}]

      %HTTPoison.Response{body: "ns:http://specs.openid.net/auth/2.0\nis_valid:true\n", status_code: 200}
    end
  end

  test "validate_payload_success" do
    assert 76561197961358433 == validate_payload(@payload, SuccessHTTPoison)
  end
end
