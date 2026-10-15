-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_provider_author_map labpkl_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labpkl_v1_provider_author_map labpkl_provider_author_map_id; Type: CONSTRAINT; Schema: labpkl_v1; Owner: -
--

ALTER TABLE ONLY labpkl_v1.labpkl_v1_provider_author_map
    ADD CONSTRAINT labpkl_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
