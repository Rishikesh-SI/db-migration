-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_user_language_map hsl_user_language_map_id
-- Type: CONSTRAINT

-- Name: labhsl_user_language_map hsl_user_language_map_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_user_language_map
    ADD CONSTRAINT hsl_user_language_map_id PRIMARY KEY (user_language_map_id);


--
