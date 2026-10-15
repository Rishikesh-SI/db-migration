-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_provider_author_map yho_provider_author_map_id
-- Type: CONSTRAINT

-- Name: yho_provider_author_map yho_provider_author_map_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_provider_author_map
    ADD CONSTRAINT yho_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
