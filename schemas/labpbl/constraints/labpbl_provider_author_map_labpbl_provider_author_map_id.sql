-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_provider_author_map labpbl_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labpbl_provider_author_map labpbl_provider_author_map_id; Type: CONSTRAINT; Schema: labpbl; Owner: -
--

ALTER TABLE ONLY labpbl.labpbl_provider_author_map
    ADD CONSTRAINT labpbl_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
