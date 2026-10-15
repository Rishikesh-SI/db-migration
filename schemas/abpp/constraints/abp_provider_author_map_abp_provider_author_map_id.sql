-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_provider_author_map abp_provider_author_map_id
-- Type: CONSTRAINT

-- Name: abp_provider_author_map abp_provider_author_map_id; Type: CONSTRAINT; Schema: abpp; Owner: -
--

ALTER TABLE ONLY abpp.abp_provider_author_map
    ADD CONSTRAINT abp_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
