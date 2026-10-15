-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_provider_author_map hsl_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labhsl_provider_author_map hsl_provider_author_map_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_provider_author_map
    ADD CONSTRAINT hsl_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
