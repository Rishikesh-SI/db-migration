-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_user_language_map scom_user_language_map_id
-- Type: CONSTRAINT

-- Name: scom_user_language_map scom_user_language_map_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_user_language_map
    ADD CONSTRAINT scom_user_language_map_id PRIMARY KEY (user_language_map_id);


--
