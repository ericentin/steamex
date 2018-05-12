defmodule Steamex.ProfileTest do
  use ExUnit.Case, async: true

  defmodule HTTPSuccess do
    @success_response %HTTPoison.Response{
      body:
        "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><profile>\r\n\t<steamID64>76561197961358433</steamID64>\r\n\t<steamID><![CDATA[whoknew]]></steamID>\r\n\t<onlineState>online</onlineState>\r\n\t<stateMessage><![CDATA[Online]]></stateMessage>\r\n\t<privacyState>public</privacyState>\r\n\t<visibilityState>3</visibilityState>\r\n\t<avatarIcon><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/4e/4ebee333fe11d2c7043ba38bdf3bf9b05437dc2a.jpg]]></avatarIcon>\r\n\t<avatarMedium><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/4e/4ebee333fe11d2c7043ba38bdf3bf9b05437dc2a_medium.jpg]]></avatarMedium>\r\n\t<avatarFull><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/4e/4ebee333fe11d2c7043ba38bdf3bf9b05437dc2a_full.jpg]]></avatarFull>\r\n\t<vacBanned>0</vacBanned>\r\n\t<tradeBanState>None</tradeBanState>\r\n\t<isLimitedAccount>0</isLimitedAccount>\r\n\t<customURL><![CDATA[ericentin]]></customURL>\r\n\t<memberSince>September 24th, 2003</memberSince>\r\n\t<steamRating></steamRating>\r\n\t<hoursPlayed2Wk>0.0</hoursPlayed2Wk>\r\n\t<headline><![CDATA[]]></headline>\r\n\t<location><![CDATA[United States]]></location>\r\n\t<realname><![CDATA[]]></realname>\r\n\t<summary><![CDATA[<img src=\"http://steamcommunity-a.akamaihd.net/economy/emoticon/csgohelmet\" class=\"emoticon\">]]></summary>\r\n \t<mostPlayedGames>\r\n\t\t<mostPlayedGame>\r\n\t\t\t<gameName><![CDATA[Rocket League]]></gameName>\r\n\t\t\t<gameLink><![CDATA[http://steamcommunity.com/app/252950]]></gameLink>\r\n\t\t\t<gameIcon><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/252950/217214f6bd922a8da8bdd684aa94b1ef8e7724d1.jpg]]></gameIcon>\r\n\t\t\t<gameLogo><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/252950/58d7334290672887fdd47e25251f291b812c895e.jpg]]></gameLogo>\r\n\t\t\t<gameLogoSmall><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/252950/58d7334290672887fdd47e25251f291b812c895e_thumb.jpg]]></gameLogoSmall>\r\n\t\t\t<hoursPlayed>2.6</hoursPlayed>\r\n\t\t\t<hoursOnRecord>2.6</hoursOnRecord>\r\n\t\t\t<statsName><![CDATA[252950]]></statsName>\r\n\t\t</mostPlayedGame>\r\n\t\t<mostPlayedGame>\r\n\t\t\t<gameName><![CDATA[Counter-Strike: Global Offensive]]></gameName>\r\n\t\t\t<gameLink><![CDATA[http://steamcommunity.com/app/730]]></gameLink>\r\n\t\t\t<gameIcon><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/730/69f7ebe2735c366c65c0b33dae00e12dc40edbe4.jpg]]></gameIcon>\r\n\t\t\t<gameLogo><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/730/d0595ff02f5c79fd19b06f4d6165c3fda2372820.jpg]]></gameLogo>\r\n\t\t\t<gameLogoSmall><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/730/d0595ff02f5c79fd19b06f4d6165c3fda2372820_thumb.jpg]]></gameLogoSmall>\r\n\t\t\t<hoursPlayed>1.5</hoursPlayed>\r\n\t\t\t<hoursOnRecord>1,033</hoursOnRecord>\r\n\t\t\t<statsName><![CDATA[CSGO]]></statsName>\r\n\t\t</mostPlayedGame>\r\n\t</mostPlayedGames>\r\n\r\n\r\n\t<groups>\r\n\t\t<group isPrimary=\"1\">\r\n\t\t\t<groupID64>103582791436613698</groupID64>\r\n\t\t\t<groupName><![CDATA[sub.io]]></groupName>\r\n\t\t\t<groupURL><![CDATA[sub_io]]></groupURL>\r\n\t\t\t<headline><![CDATA[]]></headline>\r\n\t\t\t<summary><![CDATA[No information given.]]></summary>\r\n\t\t\t<avatarIcon><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/e8/e8b84f9efdf460e0c7cea0448a00f08ed6b46812.jpg]]></avatarIcon>\r\n\t\t\t<avatarMedium><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/e8/e8b84f9efdf460e0c7cea0448a00f08ed6b46812_medium.jpg]]></avatarMedium>\r\n\t\t\t<avatarFull><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/e8/e8b84f9efdf460e0c7cea0448a00f08ed6b46812_full.jpg]]></avatarFull>\r\n\t\t\t<memberCount>125</memberCount>\r\n\t\t\t<membersInChat>0</membersInChat>\r\n\t\t\t<membersInGame>20</membersInGame>\r\n\t\t\t<membersOnline>74</membersOnline>\r\n\t\t</group>\r\n\t\t<group isPrimary=\"0\">\r\n\t\t\t<groupID64>103582791429546464</groupID64>\r\n\t\t\t<groupName><![CDATA[SOMETHING AWFUL TF2 PLAYERS]]></groupName>\r\n\t\t\t<groupURL><![CDATA[SATF2]]></groupURL>\r\n\t\t\t<headline><![CDATA[]]></headline>\r\n\t\t\t<summary><![CDATA[No information given.]]></summary>\r\n\t\t\t<avatarIcon><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb.jpg]]></avatarIcon>\r\n\t\t\t<avatarMedium><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_medium.jpg]]></avatarMedium>\r\n\t\t\t<avatarFull><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg]]></avatarFull>\r\n\t\t\t<memberCount>150</memberCount>\r\n\t\t\t<membersInChat>0</membersInChat>\r\n\t\t\t<membersInGame>9</membersInGame>\r\n\t\t\t<membersOnline>44</membersOnline>\r\n\t\t</group>\r\n\t\t<group isPrimary=\"0\">\r\n\t\t\t<groupID64>103582791429821168</groupID64>\r\n\t\t\t<groupName><![CDATA[The Killers Of Life]]></groupName>\r\n\t\t\t<groupURL><![CDATA[kornlives]]></groupURL>\r\n\t\t\t<headline><![CDATA[]]></headline>\r\n\t\t\t<summary><![CDATA[No information given.]]></summary>\r\n\t\t\t<avatarIcon><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/69/69d631f790cfad82b5b6fb25282689c65595398e.jpg]]></avatarIcon>\r\n\t\t\t<avatarMedium><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/69/69d631f790cfad82b5b6fb25282689c65595398e_medium.jpg]]></avatarMedium>\r\n\t\t\t<avatarFull><![CDATA[http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/69/69d631f790cfad82b5b6fb25282689c65595398e_full.jpg]]></avatarFull>\r\n\t\t\t<memberCount>7</memberCount>\r\n\t\t\t<membersInChat>0</membersInChat>\r\n\t\t\t<membersInGame>0</membersInGame>\r\n\t\t\t<membersOnline>2</membersOnline>\r\n\t\t</group>\r\n\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791430098698</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791430613250</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791431229266</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791431935652</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791431962114</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791431970217</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791432308751</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791432325344</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791434670817</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791434672565</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791434770827</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791434796278</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791435137310</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791435223058</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791435326100</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791435372644</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791435897724</groupID64>\r\n\t\t\t</group>\r\n\t\t\t\t\t<group isPrimary=\"0\">\r\n\t\t\t\t<groupID64>103582791436366137</groupID64>\r\n\t\t\t</group>\r\n\t\t\t</groups>\r\n</profile>",
      headers: [
        {"Server", "Apache"},
        {"Content-Security-Policy",
         "script-src 'self' 'unsafe-inline' 'unsafe-eval' http://steamcommunity-a.akamaihd.net/ https://api.steampowered.com/ http://www.google-analytics.com https://ssl.google-analytics.com https://www.google.com https://www.gstatic.com https://apis.google.com; object-src 'none'; connect-src 'self' http://steamcommunity.com https://steamcommunity.com https://api.steampowered.com/; frame-src 'self' http://store.steampowered.com/ https://store.steampowered.com/ http://www.youtube.com https://www.youtube.com https://www.google.com;"},
        {"Cache-Control", "public,max-age=3600"},
        {"Expires", "Tue, 18 Aug 2015 04:08:28 GMT"},
        {"Last-Modified", "Tue, 18 Aug 2015 03:00:00 GMT"},
        {"Content-Type", "text/xml; charset=utf-8"},
        {"X-Varnish", "1390399446"},
        {"Date", "Tue, 18 Aug 2015 04:02:21 GMT"},
        {"Content-Length", "7304"},
        {"Connection", "keep-alive"}
      ],
      status_code: 200
    }

    def get!(url, headers, opts) do
      assert url == "http://steamcommunity.com/profiles/1?xml=1"
      assert headers == []
      assert opts == [hackney: [follow_redirect: true]]

      @success_response
    end
  end

  test "fetch success" do
    assert Steamex.Profile.fetch(1, HTTPSuccess) == %Steamex.Profile{
             avatar_full:
               "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/4e/4ebee333fe11d2c7043ba38bdf3bf9b05437dc2a_full.jpg",
             avatar_icon:
               "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/4e/4ebee333fe11d2c7043ba38bdf3bf9b05437dc2a.jpg",
             avatar_medium:
               "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/4e/4ebee333fe11d2c7043ba38bdf3bf9b05437dc2a_medium.jpg",
             custom_url: "ericentin",
             groups: [
               %Steamex.Profile.Group{
                 avatar_full:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/e8/e8b84f9efdf460e0c7cea0448a00f08ed6b46812_full.jpg",
                 avatar_icon:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/e8/e8b84f9efdf460e0c7cea0448a00f08ed6b46812.jpg",
                 avatar_medium:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/e8/e8b84f9efdf460e0c7cea0448a00f08ed6b46812_medium.jpg",
                 group_id64: 103_582_791_436_613_698,
                 group_name: "sub.io",
                 group_url: "sub_io",
                 headline: "",
                 is_primary: true,
                 member_count: 125,
                 members_in_chat: 0,
                 members_in_game: 20,
                 members_online: 74,
                 summary: "No information given."
               },
               %Steamex.Profile.Group{
                 avatar_full:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg",
                 avatar_icon:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb.jpg",
                 avatar_medium:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_medium.jpg",
                 group_id64: 103_582_791_429_546_464,
                 group_name: "SOMETHING AWFUL TF2 PLAYERS",
                 group_url: "SATF2",
                 headline: "",
                 is_primary: false,
                 member_count: 150,
                 members_in_chat: 0,
                 members_in_game: 9,
                 members_online: 44,
                 summary: "No information given."
               },
               %Steamex.Profile.Group{
                 avatar_full:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/69/69d631f790cfad82b5b6fb25282689c65595398e_full.jpg",
                 avatar_icon:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/69/69d631f790cfad82b5b6fb25282689c65595398e.jpg",
                 avatar_medium:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/69/69d631f790cfad82b5b6fb25282689c65595398e_medium.jpg",
                 group_id64: 103_582_791_429_821_168,
                 group_name: "The Killers Of Life",
                 group_url: "kornlives",
                 headline: "",
                 is_primary: false,
                 member_count: 7,
                 members_in_chat: 0,
                 members_in_game: 0,
                 members_online: 2,
                 summary: "No information given."
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_430_098_698,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_430_613_250,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_431_229_266,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_431_935_652,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_431_962_114,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_431_970_217,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_432_308_751,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_432_325_344,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_434_670_817,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_434_672_565,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_434_770_827,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_434_796_278,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_435_137_310,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_435_223_058,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_435_326_100,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_435_372_644,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_435_897_724,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               },
               %Steamex.Profile.Group{
                 avatar_full: nil,
                 avatar_icon: nil,
                 avatar_medium: nil,
                 group_id64: 103_582_791_436_366_137,
                 group_name: nil,
                 group_url: nil,
                 headline: nil,
                 is_primary: false,
                 member_count: nil,
                 members_in_chat: nil,
                 members_in_game: nil,
                 members_online: nil,
                 summary: nil
               }
             ],
             headline: "",
             hours_played_2_wk: 0.0,
             is_limited_account?: false,
             location: "United States",
             member_since: "September 24th, 2003",
             most_played_games: [
               %Steamex.Profile.MostPlayedGame{
                 game_icon:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/252950/217214f6bd922a8da8bdd684aa94b1ef8e7724d1.jpg",
                 game_link: "http://steamcommunity.com/app/252950",
                 game_logo:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/252950/58d7334290672887fdd47e25251f291b812c895e.jpg",
                 game_logo_small:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/252950/58d7334290672887fdd47e25251f291b812c895e_thumb.jpg",
                 game_name: "Rocket League",
                 hours_on_record: 2.6,
                 hours_played: 2.6,
                 stats_name: "252950"
               },
               %Steamex.Profile.MostPlayedGame{
                 game_icon:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/730/69f7ebe2735c366c65c0b33dae00e12dc40edbe4.jpg",
                 game_link: "http://steamcommunity.com/app/730",
                 game_logo:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/730/d0595ff02f5c79fd19b06f4d6165c3fda2372820.jpg",
                 game_logo_small:
                   "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/730/d0595ff02f5c79fd19b06f4d6165c3fda2372820_thumb.jpg",
                 game_name: "Counter-Strike: Global Offensive",
                 hours_on_record: 1033.0,
                 hours_played: 1.5,
                 stats_name: "CSGO"
               }
             ],
             online_state: "online",
             privacy_state: "public",
             real_name: "",
             state_message: "Online",
             steam_id: "whoknew",
             steam_id64: 76_561_197_961_358_433,
             steam_rating: nil,
             summary:
               "<img src=\"http://steamcommunity-a.akamaihd.net/economy/emoticon/csgohelmet\" class=\"emoticon\">",
             trade_ban_state: "None",
             vac_banned?: false,
             visibility_state: "3"
           }
  end

  defmodule HTTPFailureCode do
    def get!(url, headers, opts) do
      assert url == "http://steamcommunity.com/profiles/1?xml=1"
      assert headers == []
      assert opts == [hackney: [follow_redirect: true]]

      %HTTPoison.Response{status_code: 404}
    end
  end

  test "fetch http fail" do
    assert_raise RuntimeError,
                 "Steam profile could not be loaded: %HTTPoison.Response{body: nil, headers: [], request_url: nil, status_code: 404}",
                 fn ->
                   Steamex.Profile.fetch(1, HTTPFailureCode)
                 end
  end

  defmodule HTTPFailureProfileError do
    @failure_response %HTTPoison.Response{
      body:
        "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><profile><error>fail</error></profile>",
      headers: [
        {"Server", "Apache"},
        {"Content-Security-Policy",
         "script-src 'self' 'unsafe-inline' 'unsafe-eval' http://steamcommunity-a.akamaihd.net/ https://api.steampowered.com/ http://www.google-analytics.com https://ssl.google-analytics.com https://www.google.com https://www.gstatic.com https://apis.google.com; object-src 'none'; connect-src 'self' http://steamcommunity.com https://steamcommunity.com https://api.steampowered.com/; frame-src 'self' http://store.steampowered.com/ https://store.steampowered.com/ http://www.youtube.com https://www.youtube.com https://www.google.com;"},
        {"Cache-Control", "public,max-age=3600"},
        {"Expires", "Tue, 18 Aug 2015 04:08:28 GMT"},
        {"Last-Modified", "Tue, 18 Aug 2015 03:00:00 GMT"},
        {"Content-Type", "text/xml; charset=utf-8"},
        {"X-Varnish", "1390399446"},
        {"Date", "Tue, 18 Aug 2015 04:02:21 GMT"},
        {"Content-Length", "7304"},
        {"Connection", "keep-alive"}
      ],
      status_code: 200
    }

    def get!(url, headers, opts) do
      assert url == "http://steamcommunity.com/profiles/1?xml=1"
      assert headers == []
      assert opts == [hackney: [follow_redirect: true]]

      @failure_response
    end
  end

  test "fetch xml profile error" do
    assert_raise RuntimeError, "fail", fn ->
      Steamex.Profile.fetch(1, HTTPFailureProfileError)
    end
  end

  defmodule HTTPFailurePrivacyMessage do
    @failure_response %HTTPoison.Response{
      body:
        "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><profile><privacyMessage>privacy message fail</privacyMessage></profile>",
      headers: [
        {"Server", "Apache"},
        {"Content-Security-Policy",
         "script-src 'self' 'unsafe-inline' 'unsafe-eval' http://steamcommunity-a.akamaihd.net/ https://api.steampowered.com/ http://www.google-analytics.com https://ssl.google-analytics.com https://www.google.com https://www.gstatic.com https://apis.google.com; object-src 'none'; connect-src 'self' http://steamcommunity.com https://steamcommunity.com https://api.steampowered.com/; frame-src 'self' http://store.steampowered.com/ https://store.steampowered.com/ http://www.youtube.com https://www.youtube.com https://www.google.com;"},
        {"Cache-Control", "public,max-age=3600"},
        {"Expires", "Tue, 18 Aug 2015 04:08:28 GMT"},
        {"Last-Modified", "Tue, 18 Aug 2015 03:00:00 GMT"},
        {"Content-Type", "text/xml; charset=utf-8"},
        {"X-Varnish", "1390399446"},
        {"Date", "Tue, 18 Aug 2015 04:02:21 GMT"},
        {"Content-Length", "7304"},
        {"Connection", "keep-alive"}
      ],
      status_code: 200
    }

    def get!(url, headers, opts) do
      assert url == "http://steamcommunity.com/profiles/1?xml=1"
      assert headers == []
      assert opts == [hackney: [follow_redirect: true]]

      @failure_response
    end
  end

  test "fetch xml privacy message" do
    assert_raise RuntimeError, "privacy message fail", fn ->
      Steamex.Profile.fetch(1, HTTPFailurePrivacyMessage)
    end
  end
end
