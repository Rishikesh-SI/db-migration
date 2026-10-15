-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_provider_author_map labwis_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labwis_provider_author_map labwis_provider_author_map_id; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_provider_author_map
    ADD CONSTRAINT labwis_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
