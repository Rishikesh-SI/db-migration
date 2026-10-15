-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_user_language_map tcs_user_language_map_id
-- Type: CONSTRAINT

-- Name: tcs_user_language_map tcs_user_language_map_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_user_language_map
    ADD CONSTRAINT tcs_user_language_map_id PRIMARY KEY (user_language_map_id);


--
