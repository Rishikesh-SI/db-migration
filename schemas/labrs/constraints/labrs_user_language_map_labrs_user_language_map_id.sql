-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_user_language_map labrs_user_language_map_id
-- Type: CONSTRAINT

-- Name: labrs_user_language_map labrs_user_language_map_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_user_language_map
    ADD CONSTRAINT labrs_user_language_map_id PRIMARY KEY (user_language_map_id);


--
