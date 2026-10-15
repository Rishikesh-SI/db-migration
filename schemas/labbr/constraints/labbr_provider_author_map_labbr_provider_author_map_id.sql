-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_provider_author_map labbr_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labbr_provider_author_map labbr_provider_author_map_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_provider_author_map
    ADD CONSTRAINT labbr_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
