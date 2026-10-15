-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_provider_author_map labgsoc_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labgsoc_provider_author_map labgsoc_provider_author_map_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_provider_author_map
    ADD CONSTRAINT labgsoc_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
