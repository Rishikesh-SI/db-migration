-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_provider_author_map labrao_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labrao_provider_author_map labrao_provider_author_map_id; Type: CONSTRAINT; Schema: labrao; Owner: -
--

ALTER TABLE ONLY labrao.labrao_provider_author_map
    ADD CONSTRAINT labrao_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
