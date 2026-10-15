-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_user_language_map labrstg_user_language_map_id
-- Type: CONSTRAINT

-- Name: labrstg_user_language_map labrstg_user_language_map_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_user_language_map
    ADD CONSTRAINT labrstg_user_language_map_id PRIMARY KEY (user_language_map_id);


--
