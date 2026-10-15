-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_user_language_map yho_user_language_map_id
-- Type: CONSTRAINT

-- Name: yho_user_language_map yho_user_language_map_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_user_language_map
    ADD CONSTRAINT yho_user_language_map_id PRIMARY KEY (user_language_map_id);


--
