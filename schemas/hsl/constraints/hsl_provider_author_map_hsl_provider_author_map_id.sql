-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_provider_author_map hsl_provider_author_map_id
-- Type: CONSTRAINT

-- Name: hsl_provider_author_map hsl_provider_author_map_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_provider_author_map
    ADD CONSTRAINT hsl_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
