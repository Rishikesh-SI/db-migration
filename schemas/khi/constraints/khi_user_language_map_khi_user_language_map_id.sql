-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_user_language_map khi_user_language_map_id
-- Type: CONSTRAINT

-- Name: khi_user_language_map khi_user_language_map_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_user_language_map
    ADD CONSTRAINT khi_user_language_map_id PRIMARY KEY (user_language_map_id);


--
