-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_user_language_map labpr_user_language_map_id
-- Type: CONSTRAINT

-- Name: labpr_user_language_map labpr_user_language_map_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_user_language_map
    ADD CONSTRAINT labpr_user_language_map_id PRIMARY KEY (user_language_map_id);


--
