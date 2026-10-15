-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_tour_player ss_tour_player_pk
-- Type: CONSTRAINT

-- Name: ss_tour_player ss_tour_player_pk; Type: CONSTRAINT; Schema: eks; Owner: -
--

ALTER TABLE ONLY eks.ss_tour_player
    ADD CONSTRAINT ss_tour_player_pk PRIMARY KEY (cf_playerid, cf_tourid);


--
