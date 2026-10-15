-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_provider_author_map labgmr_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labgmr_provider_author_map labgmr_provider_author_map_id; Type: CONSTRAINT; Schema: labgmr; Owner: -
--

ALTER TABLE ONLY labgmr.labgmr_provider_author_map
    ADD CONSTRAINT labgmr_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
