-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_provider_author_map isl_provider_author_map_id
-- Type: CONSTRAINT

-- Name: isl_provider_author_map isl_provider_author_map_id; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_provider_author_map
    ADD CONSTRAINT isl_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
