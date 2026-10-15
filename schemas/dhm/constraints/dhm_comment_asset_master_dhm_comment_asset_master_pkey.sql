-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_comment_asset_master dhm_comment_asset_master_pkey
-- Type: CONSTRAINT

-- Name: dhm_comment_asset_master dhm_comment_asset_master_pkey; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_comment_asset_master
    ADD CONSTRAINT dhm_comment_asset_master_pkey PRIMARY KEY (asset_id, asset_type_id);


--
