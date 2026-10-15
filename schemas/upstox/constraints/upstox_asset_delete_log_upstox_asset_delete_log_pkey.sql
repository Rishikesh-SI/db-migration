-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_asset_delete_log upstox_asset_delete_log_pkey
-- Type: CONSTRAINT

-- Name: upstox_asset_delete_log upstox_asset_delete_log_pkey; Type: CONSTRAINT; Schema: upstox; Owner: -
--

ALTER TABLE ONLY upstox.upstox_asset_delete_log
    ADD CONSTRAINT upstox_asset_delete_log_pkey PRIMARY KEY (asset_delete_log_id);


--
