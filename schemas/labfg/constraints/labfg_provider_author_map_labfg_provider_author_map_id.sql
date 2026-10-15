-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_provider_author_map labfg_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labfg_provider_author_map labfg_provider_author_map_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_provider_author_map
    ADD CONSTRAINT labfg_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
