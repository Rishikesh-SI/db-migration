-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_user_language_map labpcm_user_language_map_id
-- Type: CONSTRAINT

-- Name: labpcm_user_language_map labpcm_user_language_map_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_user_language_map
    ADD CONSTRAINT labpcm_user_language_map_id PRIMARY KEY (user_language_map_id);


--
