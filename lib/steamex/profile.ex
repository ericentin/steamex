defmodule Steamex.Profile do
  import SweetXml

  defmodule MostPlayedGame do
    defstruct game_name: nil,
              game_link: nil,
              game_icon: nil,
              game_logo: nil,
              game_logo_small: nil,
              hours_played: nil,
              hours_on_record: nil,
              stats_name: nil

    @type t :: %__MODULE__{
            game_name: binary | nil,
            game_link: binary | nil,
            game_icon: binary | nil,
            game_logo: binary | nil,
            game_logo_small: binary | nil,
            hours_played: float | nil,
            hours_on_record: float | nil,
            stats_name: binary | nil
          }
  end

  defmodule Group do
    defstruct group_id64: nil,
              group_name: nil,
              group_url: nil,
              is_primary: nil,
              headline: nil,
              summary: nil,
              avatar_icon: nil,
              avatar_medium: nil,
              avatar_full: nil,
              member_count: nil,
              members_in_chat: nil,
              members_in_game: nil,
              members_online: nil

    @type t :: %__MODULE__{
            group_id64: integer | nil,
            group_name: binary | nil,
            group_url: binary | nil,
            is_primary: boolean | nil,
            headline: binary | nil,
            summary: binary | nil,
            avatar_icon: binary | nil,
            avatar_medium: binary | nil,
            avatar_full: binary | nil,
            member_count: integer | nil,
            members_in_chat: integer | nil,
            members_in_game: integer | nil,
            members_online: integer | nil
          }
  end

  defstruct steam_id64: nil,
            steam_id: nil,
            online_state: nil,
            state_message: nil,
            privacy_state: nil,
            visibility_state: nil,
            avatar_icon: nil,
            avatar_medium: nil,
            avatar_full: nil,
            vac_banned?: nil,
            trade_ban_state: nil,
            is_limited_account?: nil,
            custom_url: nil,
            member_since: nil,
            steam_rating: nil,
            hours_played_2_wk: nil,
            headline: nil,
            location: nil,
            real_name: nil,
            summary: nil,
            most_played_games: [],
            groups: []

  @type t :: %Steamex.Profile{
          steam_id64: integer | nil,
          steam_id: binary | nil,
          online_state: binary | nil,
          state_message: binary | nil,
          privacy_state: binary | nil,
          visibility_state: binary | nil,
          avatar_icon: binary | nil,
          avatar_medium: binary | nil,
          avatar_full: binary | nil,
          vac_banned?: boolean | nil,
          trade_ban_state: binary | nil,
          is_limited_account?: boolean | nil,
          custom_url: binary | nil,
          member_since: binary | nil,
          steam_rating: float | nil,
          hours_played_2_wk: float | nil,
          headline: binary | nil,
          location: binary | nil,
          real_name: binary | nil,
          summary: binary | nil,
          most_played_games: [MostPlayedGame.t()],
          groups: [Group.t()]
        }

  @doc """
  Fetch the profile for the given 64-bit community SteamID or custom URL.
  """
  @spec fetch(pos_integer | binary) :: Steamex.Profile.t()
  def fetch(community_id_or_custom_url) do
    fetch(community_id_or_custom_url, HTTPoison)
  end

  @doc false
  def fetch(community_id_or_custom_url, httpoison) do
    base_url = Steamex.SteamID.base_url(community_id_or_custom_url) <> "?xml=1"

    Application.ensure_all_started(:httpoison)

    response = httpoison.get!(base_url, [], hackney: [follow_redirect: true])

    case response do
      %HTTPoison.Response{status_code: 200, body: body} -> from_xml(body)
      resp -> raise "Steam profile could not be loaded: #{inspect(resp)}"
    end
  end

  @doc false
  defp from_xml(doc) do
    profile = xpath(doc, ~x"//profile")

    error = extract_string(profile, ~x"//error/text()")

    if error, do: raise(error)

    privacy_message = extract_string(profile, ~x"//privacyMessage/text()")

    if privacy_message, do: raise(privacy_message)

    most_played_games =
      for most_played_game <- xpath(profile, ~x"//mostPlayedGames/mostPlayedGame"l) do
        %Steamex.Profile.MostPlayedGame{
          game_name: extract_string(most_played_game, ~x"//gameName/text()"),
          game_link: extract_string(most_played_game, ~x"//gameLink/text()"),
          game_icon: extract_string(most_played_game, ~x"//gameIcon/text()"),
          game_logo: extract_string(most_played_game, ~x"//gameLogo/text()"),
          game_logo_small: extract_string(most_played_game, ~x"//gameLogoSmall/text()"),
          hours_played: extract_float(most_played_game, ~x"//hoursPlayed/text()"),
          hours_on_record: extract_float(most_played_game, ~x"//hoursOnRecord/text()"),
          stats_name: extract_string(most_played_game, ~x"//statsName/text()")
        }
      end

    groups =
      for group <- xpath(profile, ~x"//groups/group"l) do
        %Steamex.Profile.Group{
          group_id64: extract_integer(group, ~x"//groupID64/text()"),
          group_name: extract_string(group, ~x"//groupName/text()"),
          group_url: extract_string(group, ~x"//groupURL/text()"),
          is_primary: extract_boolean(group, ~x"//@isPrimary"),
          headline: extract_string(group, ~x"//headline/text()"),
          summary: extract_string(group, ~x"//summary/text()"),
          avatar_icon: extract_string(group, ~x"//avatarIcon/text()"),
          avatar_medium: extract_string(group, ~x"//avatarMedium/text()"),
          avatar_full: extract_string(group, ~x"//avatarFull/text()"),
          member_count: extract_integer(group, ~x"//memberCount/text()"),
          members_in_chat: extract_integer(group, ~x"//membersInChat/text()"),
          members_in_game: extract_integer(group, ~x"//membersInGame/text()"),
          members_online: extract_integer(group, ~x"//membersOnline/text()")
        }
      end

    %Steamex.Profile{
      steam_id64: extract_integer(profile, ~x"//steamID64/text()"),
      steam_id: extract_string(profile, ~x"//steamID/text()"),
      online_state: extract_string(profile, ~x"//onlineState/text()"),
      state_message: extract_string(profile, ~x"//stateMessage/text()"),
      privacy_state: extract_string(profile, ~x"//privacyState/text()"),
      visibility_state: extract_string(profile, ~x"//visibilityState/text()"),
      avatar_icon: extract_string(profile, ~x"//avatarIcon/text()"),
      avatar_medium: extract_string(profile, ~x"//avatarMedium/text()"),
      avatar_full: extract_string(profile, ~x"//avatarFull/text()"),
      vac_banned?: extract_boolean(profile, ~x"//vacBanned/text()"),
      trade_ban_state: extract_string(profile, ~x"//tradeBanState/text()"),
      is_limited_account?: extract_boolean(profile, ~x"//isLimitedAccount/text()"),
      custom_url: extract_string(profile, ~x"//customURL/text()"),
      member_since: extract_string(profile, ~x"//memberSince/text()"),
      steam_rating: extract_float(profile, ~x"//steamRating/text()"),
      hours_played_2_wk: extract_float(profile, ~x"//hoursPlayed2Wk/text()"),
      headline: extract_string(profile, ~x"//headline/text()"),
      location: extract_string(profile, ~x"//location/text()"),
      real_name: extract_string(profile, ~x"//realname/text()"),
      summary: extract_string(profile, ~x"//summary/text()"),
      most_played_games: most_played_games,
      groups: groups
    }
  end

  defp extract_string(entity, xpath) do
    case xpath(entity, xpath) do
      nil -> nil
      result -> List.to_string(result)
    end
  end

  defp extract_integer(entity, xpath) do
    case extract_string(entity, xpath) do
      nil ->
        nil

      result ->
        {result, ""} = Integer.parse(result)

        result
    end
  end

  defp extract_float(entity, xpath) do
    case extract_string(entity, xpath) do
      nil ->
        nil

      result ->
        {result, ""} =
          String.replace(result, ",", "")
          |> Float.parse()

        result
    end
  end

  defp extract_boolean(entity, xpath) do
    case extract_string(entity, xpath) do
      "1" -> true
      "0" -> false
      nil -> nil
    end
  end
end
