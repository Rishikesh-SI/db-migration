-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_user_language_map upy_user_language_map_id
-- Type: CONSTRAINT

-- Name: upy_user_language_map upy_user_language_map_id; Type: CONSTRAINT; Schema: upy; Owner: -
--

ALTER TABLE ONLY upy.upy_user_language_map
    ADD CONSTRAINT upy_user_language_map_id PRIMARY KEY (user_language_map_id);


--
