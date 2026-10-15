-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_series_match_map gpn_series_match_map_pkey
-- Type: CONSTRAINT

-- Name: gpn_series_match_map gpn_series_match_map_pkey; Type: CONSTRAINT; Schema: gpnv2; Owner: -
--

ALTER TABLE ONLY gpnv2.gpn_series_match_map
    ADD CONSTRAINT gpn_series_match_map_pkey PRIMARY KEY (series_map_id);


--
