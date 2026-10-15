-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_provider_author_map ppb_provider_author_map_id
-- Type: CONSTRAINT

-- Name: ppb_provider_author_map ppb_provider_author_map_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_provider_author_map
    ADD CONSTRAINT ppb_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
