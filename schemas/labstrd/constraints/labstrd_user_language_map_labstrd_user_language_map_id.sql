-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_user_language_map labstrd_user_language_map_id
-- Type: CONSTRAINT

-- Name: labstrd_user_language_map labstrd_user_language_map_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_user_language_map
    ADD CONSTRAINT labstrd_user_language_map_id PRIMARY KEY (user_language_map_id);


--
