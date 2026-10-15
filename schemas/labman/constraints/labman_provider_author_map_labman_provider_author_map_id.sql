-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_provider_author_map labman_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labman_provider_author_map labman_provider_author_map_id; Type: CONSTRAINT; Schema: labman; Owner: -
--

ALTER TABLE ONLY labman.labman_provider_author_map
    ADD CONSTRAINT labman_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
