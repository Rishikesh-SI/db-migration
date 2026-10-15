-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_provider_author_map msl_provider_author_map_id
-- Type: CONSTRAINT

-- Name: msl_provider_author_map msl_provider_author_map_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_provider_author_map
    ADD CONSTRAINT msl_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
