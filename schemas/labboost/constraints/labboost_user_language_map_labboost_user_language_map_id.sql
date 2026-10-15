-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_user_language_map labboost_user_language_map_id
-- Type: CONSTRAINT

-- Name: labboost_user_language_map labboost_user_language_map_id; Type: CONSTRAINT; Schema: labboost; Owner: -
--

ALTER TABLE ONLY labboost.labboost_user_language_map
    ADD CONSTRAINT labboost_user_language_map_id PRIMARY KEY (user_language_map_id);


--
