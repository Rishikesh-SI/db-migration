-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_provider_author_map jafc_provider_author_map_id
-- Type: CONSTRAINT

-- Name: jafc_provider_author_map jafc_provider_author_map_id; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_provider_author_map
    ADD CONSTRAINT jafc_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
