-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_user_language_map labets_user_language_map_id
-- Type: CONSTRAINT

-- Name: labets_user_language_map labets_user_language_map_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_user_language_map
    ADD CONSTRAINT labets_user_language_map_id PRIMARY KEY (user_language_map_id);


--
