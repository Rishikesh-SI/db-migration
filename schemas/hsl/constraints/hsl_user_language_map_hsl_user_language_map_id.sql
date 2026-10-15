-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_user_language_map hsl_user_language_map_id
-- Type: CONSTRAINT

-- Name: hsl_user_language_map hsl_user_language_map_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_user_language_map
    ADD CONSTRAINT hsl_user_language_map_id PRIMARY KEY (user_language_map_id);


--
