-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_provider_author_map labstrd_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labstrd_provider_author_map labstrd_provider_author_map_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_provider_author_map
    ADD CONSTRAINT labstrd_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
