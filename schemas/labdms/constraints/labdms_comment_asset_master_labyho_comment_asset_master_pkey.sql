-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_comment_asset_master labyho_comment_asset_master_pkey
-- Type: CONSTRAINT

-- Name: labdms_comment_asset_master labyho_comment_asset_master_pkey; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_comment_asset_master
    ADD CONSTRAINT labyho_comment_asset_master_pkey PRIMARY KEY (asset_id, asset_type_id);


--
