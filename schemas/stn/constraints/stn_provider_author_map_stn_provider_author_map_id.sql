-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_provider_author_map stn_provider_author_map_id
-- Type: CONSTRAINT

-- Name: stn_provider_author_map stn_provider_author_map_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_provider_author_map
    ADD CONSTRAINT stn_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
