-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_nlp_assets
-- Type: VIEW

-- Name: sibot_nlp_assets; Type: VIEW; Schema: sibot; Owner: -
--

CREATE VIEW sibot.sibot_nlp_assets AS
 SELECT a.category_id,
    a.category_name,
    a.synonyms,
    string_agg((a.id)::text, ','::text) AS ids
   FROM ( SELECT 1 AS category_id,
            'players'::text AS category_name,
            sibot_player.player_id AS id,
            btrim(unnest(string_to_array(((sibot_player.meta_data || ','::text) || sibot_player.player_name), ','::text)), ' '::text) AS synonyms
           FROM sibot.sibot_player
          WHERE ((sibot_player.meta_data IS NOT NULL) OR (sibot_player.meta_data <> ''::text))
          GROUP BY sibot_player.player_id, (unnest(string_to_array(((sibot_player.meta_data || ','::text) || sibot_player.player_name), ','::text)))
        UNION
         SELECT 2 AS category_id,
            'teams'::text AS category_name,
            sibot_team.team_id AS id,
            btrim(unnest(string_to_array(((sibot_team.meta_data || ','::text) || sibot_team.team_name), ','::text)), ' '::text) AS synonyms
           FROM sibot.sibot_team
          WHERE ((sibot_team.meta_data IS NOT NULL) OR (sibot_team.meta_data <> ''::text))
          GROUP BY sibot_team.team_id, (unnest(string_to_array(((sibot_team.meta_data || ','::text) || sibot_team.team_name), ','::text)))
        UNION
         SELECT 3 AS category_id,
            'venues'::text AS category_name,
            sibot_venue.venue_id AS id,
            btrim(unnest(string_to_array(((sibot_venue.meta_data || ','::text) || sibot_venue.venue_name), ','::text)), ' '::text) AS synonyms
           FROM sibot.sibot_venue
          WHERE ((sibot_venue.meta_data IS NOT NULL) OR (sibot_venue.meta_data <> ''::text))
          GROUP BY sibot_venue.venue_id, (unnest(string_to_array(((sibot_venue.meta_data || ','::text) || sibot_venue.venue_name), ','::text)))
        UNION
         SELECT 4 AS country_id,
            'countries'::text AS category_name,
            sibot_country.country_id AS id,
            btrim(unnest(string_to_array(((sibot_country.meta_data || ','::text) || sibot_country.country_name), ','::text)), ' '::text) AS synonyms
           FROM sibot.sibot_country
          WHERE ((sibot_country.meta_data IS NOT NULL) OR (sibot_country.meta_data <> ''::text))
          GROUP BY sibot_country.country_id, (unnest(string_to_array(((sibot_country.meta_data || ','::text) || sibot_country.country_name), ','::text)))) a
  GROUP BY a.category_id, a.category_name, a.synonyms
  ORDER BY a.synonyms;


--
