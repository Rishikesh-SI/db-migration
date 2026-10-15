-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_user_language_map labsm_user_language_map_id
-- Type: CONSTRAINT

-- Name: labsm_user_language_map labsm_user_language_map_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_user_language_map
    ADD CONSTRAINT labsm_user_language_map_id PRIMARY KEY (user_language_map_id);


--
