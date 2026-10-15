-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_provider_author_map pkl_provider_author_map_id
-- Type: CONSTRAINT

-- Name: pkl_provider_author_map pkl_provider_author_map_id; Type: CONSTRAINT; Schema: pkl; Owner: -
--

ALTER TABLE ONLY pkl.pkl_provider_author_map
    ADD CONSTRAINT pkl_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
