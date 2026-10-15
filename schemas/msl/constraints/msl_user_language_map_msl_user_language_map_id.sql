-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_user_language_map msl_user_language_map_id
-- Type: CONSTRAINT

-- Name: msl_user_language_map msl_user_language_map_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_user_language_map
    ADD CONSTRAINT msl_user_language_map_id PRIMARY KEY (user_language_map_id);


--
