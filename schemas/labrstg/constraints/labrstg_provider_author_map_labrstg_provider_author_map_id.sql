-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_provider_author_map labrstg_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labrstg_provider_author_map labrstg_provider_author_map_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_provider_author_map
    ADD CONSTRAINT labrstg_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
