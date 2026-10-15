-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_provider_author_map labgg_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labgg_provider_author_map labgg_provider_author_map_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_provider_author_map
    ADD CONSTRAINT labgg_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
