-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_user_language_map labtri_user_language_map_id
-- Type: CONSTRAINT

-- Name: labtri_user_language_map labtri_user_language_map_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_user_language_map
    ADD CONSTRAINT labtri_user_language_map_id PRIMARY KEY (user_language_map_id);


--
