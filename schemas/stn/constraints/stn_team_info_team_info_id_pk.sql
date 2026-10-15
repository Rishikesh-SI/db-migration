-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_team_info team_info_id_pk
-- Type: CONSTRAINT

-- Name: stn_team_info team_info_id_pk; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_team_info
    ADD CONSTRAINT team_info_id_pk PRIMARY KEY (team_id);


--
