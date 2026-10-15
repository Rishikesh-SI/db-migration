-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_sport_map zeven_user_sport_map_user_id_sport_id_pk
-- Type: CONSTRAINT

-- Name: zeven_user_sport_map zeven_user_sport_map_user_id_sport_id_pk; Type: CONSTRAINT; Schema: zeven; Owner: -
--

ALTER TABLE ONLY zeven.zeven_user_sport_map
    ADD CONSTRAINT zeven_user_sport_map_user_id_sport_id_pk PRIMARY KEY (user_id, sportid);


--
