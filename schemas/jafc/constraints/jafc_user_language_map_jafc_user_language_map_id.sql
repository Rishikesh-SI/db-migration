-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_user_language_map jafc_user_language_map_id
-- Type: CONSTRAINT

-- Name: jafc_user_language_map jafc_user_language_map_id; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_user_language_map
    ADD CONSTRAINT jafc_user_language_map_id PRIMARY KEY (user_language_map_id);


--
