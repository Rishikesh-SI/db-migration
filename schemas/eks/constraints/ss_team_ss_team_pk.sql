-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_team ss_team_pk
-- Type: CONSTRAINT

-- Name: ss_team ss_team_pk; Type: CONSTRAINT; Schema: eks; Owner: -
--

ALTER TABLE ONLY eks.ss_team
    ADD CONSTRAINT ss_team_pk PRIMARY KEY (cf_teamid);


--
