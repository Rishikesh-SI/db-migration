-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_provider_author_map labsm_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labsm_provider_author_map labsm_provider_author_map_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_provider_author_map
    ADD CONSTRAINT labsm_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
