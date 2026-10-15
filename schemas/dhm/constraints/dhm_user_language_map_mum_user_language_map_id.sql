-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_user_language_map mum_user_language_map_id
-- Type: CONSTRAINT

-- Name: dhm_user_language_map mum_user_language_map_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_user_language_map
    ADD CONSTRAINT mum_user_language_map_id PRIMARY KEY (user_language_map_id);


--
