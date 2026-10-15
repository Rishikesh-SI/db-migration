-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_provider_author_map labrs_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labrs_provider_author_map labrs_provider_author_map_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_provider_author_map
    ADD CONSTRAINT labrs_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
