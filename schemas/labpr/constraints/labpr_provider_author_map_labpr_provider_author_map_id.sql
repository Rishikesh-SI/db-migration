-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_provider_author_map labpr_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labpr_provider_author_map labpr_provider_author_map_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_provider_author_map
    ADD CONSTRAINT labpr_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
