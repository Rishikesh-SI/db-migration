-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_comment_asset_master labyho_comment_asset_master_pkey
-- Type: CONSTRAINT

-- Name: labyho_comment_asset_master labyho_comment_asset_master_pkey; Type: CONSTRAINT; Schema: labyho; Owner: -
--

ALTER TABLE ONLY labyho.labyho_comment_asset_master
    ADD CONSTRAINT labyho_comment_asset_master_pkey PRIMARY KEY (asset_id, asset_type_id);


--
