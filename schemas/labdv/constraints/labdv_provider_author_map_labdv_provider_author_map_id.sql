-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_provider_author_map labdv_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labdv_provider_author_map labdv_provider_author_map_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_provider_author_map
    ADD CONSTRAINT labdv_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
