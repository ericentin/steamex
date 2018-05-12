defmodule Steamex.SteamID do
  @moduledoc """
    Various utility functions related to SteamIDs.
  """

  @doc """
  Converts a 64-bit community SteamID to the legacy SteamID format.

  ## Examples

      iex> Steamex.SteamID.community_id_to_steam_id(76561197961358433)
      "STEAM_0:1:546352"
  """
  @spec community_id_to_steam_id(pos_integer) :: binary
  def community_id_to_steam_id(community_id) do
    steam_id1 = rem(community_id, 2)
    steam_id2 = community_id - 76_561_197_960_265_728

    unless steam_id2 > 0 do
      raise "SteamID #{community_id} is too small."
    end

    steam_id2 = div(steam_id2 - steam_id1, 2)

    "STEAM_0:#{steam_id1}:#{steam_id2}"
  end

  @doc """
  Converts a 64-bit community SteamID to the modern SteamID format (aka SteamID 3)

  ## Examples

      iex> Steamex.SteamID.community_id_to_steam_id3(76561197961358433)
      "[U:1:1092705]"
  """
  @spec community_id_to_steam_id3(pos_integer) :: binary
  def community_id_to_steam_id3(community_id) do
    unless rem(community_id, 2) == 1 do
      raise "SteamID3 only supports public universe"
    end

    steam_id2 = community_id - 76_561_197_960_265_728

    unless steam_id2 > 0 do
      raise "SteamID #{community_id} is too small."
    end

    "[U:1:#{steam_id2}]"
  end

  @doc """
  Converts a SteamID as reported by game servers or a SteamID3 to a 64-bit
  community SteamID.

  ## Examples

      iex> Steamex.SteamID.steam_id_to_community_id("STEAM_0:1:546352")
      76561197961358433

      iex> Steamex.SteamID.steam_id_to_community_id("[U:1:1092705]")
      76561197961358433
  """
  @spec steam_id_to_community_id(binary) :: pos_integer
  def steam_id_to_community_id(
        <<"STEAM_", _::binary-size(1), ":", steam_id1::binary-size(1), ":", steam_id2::binary>>
      ) do
    {steam_id1, ""} = Integer.parse(steam_id1)
    {steam_id2, ""} = Integer.parse(steam_id2)
    steam_id1 + steam_id2 * 2 + 76_561_197_960_265_728
  end

  def steam_id_to_community_id(<<"[U:", steam_id1::binary-size(1), ":", steam_id2::binary>>) do
    {steam_id1, ""} = Integer.parse(steam_id1)
    {steam_id2, "]"} = Integer.parse(steam_id2)
    steam_id1 + steam_id2 + 76_561_197_960_265_727
  end

  def steam_id_to_community_id(steam_id) do
    raise "Cannot convert SteamID \"#{steam_id}\" to a community ID."
  end

  @doc """
  Returns the base URL for the given 64-bit community SteamID or custom URL.

  ## Examples

      iex> Steamex.SteamID.base_url(76561197961358433)
      "http://steamcommunity.com/profiles/76561197961358433"

      iex> Steamex.SteamID.base_url("ericentin")
      "http://steamcommunity.com/id/ericentin"
  """
  @spec base_url(pos_integer | binary) :: binary
  def base_url(community_id_or_custom_url) when is_integer(community_id_or_custom_url) do
    "http://steamcommunity.com/profiles/#{community_id_or_custom_url}"
  end

  def base_url(community_id_or_custom_url) when is_binary(community_id_or_custom_url) do
    "http://steamcommunity.com/id/#{community_id_or_custom_url}"
  end
end
