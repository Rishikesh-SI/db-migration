-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_user_language_map labbr_user_language_map_id
-- Type: CONSTRAINT

-- Name: labbr_user_language_map labbr_user_language_map_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_user_language_map
    ADD CONSTRAINT labbr_user_language_map_id PRIMARY KEY (user_language_map_id);


--
