-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_provider_author_map labbsc_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labbsc_provider_author_map labbsc_provider_author_map_id; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_provider_author_map
    ADD CONSTRAINT labbsc_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
