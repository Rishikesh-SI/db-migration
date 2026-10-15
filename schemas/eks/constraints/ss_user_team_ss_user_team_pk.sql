-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user_team ss_user_team_pk
-- Type: CONSTRAINT

-- Name: ss_user_team ss_user_team_pk; Type: CONSTRAINT; Schema: eks; Owner: -
--

ALTER TABLE ONLY eks.ss_user_team
    ADD CONSTRAINT ss_user_team_pk PRIMARY KEY (cf_userid, cf_playerid, cf_tourid);


--
