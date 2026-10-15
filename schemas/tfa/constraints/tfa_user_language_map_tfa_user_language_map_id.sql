-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_user_language_map tfa_user_language_map_id
-- Type: CONSTRAINT

-- Name: tfa_user_language_map tfa_user_language_map_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_user_language_map
    ADD CONSTRAINT tfa_user_language_map_id PRIMARY KEY (user_language_map_id);


--
