-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_provider_author_map labstmp_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labstmp_provider_author_map labstmp_provider_author_map_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_provider_author_map
    ADD CONSTRAINT labstmp_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
