-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_user_language_map labdv_user_language_map_id
-- Type: CONSTRAINT

-- Name: labdv_user_language_map labdv_user_language_map_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_user_language_map
    ADD CONSTRAINT labdv_user_language_map_id PRIMARY KEY (user_language_map_id);


--
