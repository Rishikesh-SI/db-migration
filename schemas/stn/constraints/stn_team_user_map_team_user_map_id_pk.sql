-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_team_user_map team_user_map_id_pk
-- Type: CONSTRAINT

-- Name: stn_team_user_map team_user_map_id_pk; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_team_user_map
    ADD CONSTRAINT team_user_map_id_pk PRIMARY KEY (team_user_map_id);


--
