-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_user_language_map labgt_user_language_map_id
-- Type: CONSTRAINT

-- Name: labgt_user_language_map labgt_user_language_map_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_user_language_map
    ADD CONSTRAINT labgt_user_language_map_id PRIMARY KEY (user_language_map_id);


--
