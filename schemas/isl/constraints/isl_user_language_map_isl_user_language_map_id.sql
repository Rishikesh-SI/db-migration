-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_user_language_map isl_user_language_map_id
-- Type: CONSTRAINT

-- Name: isl_user_language_map isl_user_language_map_id; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_user_language_map
    ADD CONSTRAINT isl_user_language_map_id PRIMARY KEY (user_language_map_id);


--
