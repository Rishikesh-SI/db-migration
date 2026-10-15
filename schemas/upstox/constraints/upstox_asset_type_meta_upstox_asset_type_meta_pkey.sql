-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_asset_type_meta upstox_asset_type_meta_pkey
-- Type: CONSTRAINT

-- Name: upstox_asset_type_meta upstox_asset_type_meta_pkey; Type: CONSTRAINT; Schema: upstox; Owner: -
--

ALTER TABLE ONLY upstox.upstox_asset_type_meta
    ADD CONSTRAINT upstox_asset_type_meta_pkey PRIMARY KEY (asset_type_meta_id);


--
