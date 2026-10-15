-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_provider_author_map labpcm_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labpcm_provider_author_map labpcm_provider_author_map_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_provider_author_map
    ADD CONSTRAINT labpcm_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
