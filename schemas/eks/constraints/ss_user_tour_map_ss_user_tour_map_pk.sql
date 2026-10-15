-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user_tour_map ss_user_tour_map_pk
-- Type: CONSTRAINT

-- Name: ss_user_tour_map ss_user_tour_map_pk; Type: CONSTRAINT; Schema: eks; Owner: -
--

ALTER TABLE ONLY eks.ss_user_tour_map
    ADD CONSTRAINT ss_user_tour_map_pk PRIMARY KEY (cf_userid, cf_tourid);


--
