-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_player_tour_selection ss_player_tour_selection_pk
-- Type: CONSTRAINT

-- Name: ss_player_tour_selection ss_player_tour_selection_pk; Type: CONSTRAINT; Schema: eks; Owner: -
--

ALTER TABLE ONLY eks.ss_player_tour_selection
    ADD CONSTRAINT ss_player_tour_selection_pk PRIMARY KEY (cf_playerid, cf_tourid);


--
