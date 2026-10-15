-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_provider_author_map kxp_provider_author_map_id
-- Type: CONSTRAINT

-- Name: dd_provider_author_map kxp_provider_author_map_id; Type: CONSTRAINT; Schema: dd; Owner: -
--

ALTER TABLE ONLY dd.dd_provider_author_map
    ADD CONSTRAINT kxp_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
