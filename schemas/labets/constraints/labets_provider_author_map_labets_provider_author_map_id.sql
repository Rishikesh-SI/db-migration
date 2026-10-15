-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_provider_author_map labets_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labets_provider_author_map labets_provider_author_map_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_provider_author_map
    ADD CONSTRAINT labets_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
