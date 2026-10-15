-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_provider_author_map labboost_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labboost_provider_author_map labboost_provider_author_map_id; Type: CONSTRAINT; Schema: labboost; Owner: -
--

ALTER TABLE ONLY labboost.labboost_provider_author_map
    ADD CONSTRAINT labboost_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
