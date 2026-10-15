-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_league_team_map gpn_league_team_map_id_pk
-- Type: CONSTRAINT

-- Name: gpn_league_team_map gpn_league_team_map_id_pk; Type: CONSTRAINT; Schema: gpn; Owner: -
--

ALTER TABLE ONLY gpn.gpn_league_team_map
    ADD CONSTRAINT gpn_league_team_map_id_pk PRIMARY KEY (league_team_map_id);


--
