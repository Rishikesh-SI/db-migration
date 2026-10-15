-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_asset_delete_log labbsc_dev_asset_delete_log_pkey
-- Type: CONSTRAINT

-- Name: labbsc_dev_asset_delete_log labbsc_dev_asset_delete_log_pkey; Type: CONSTRAINT; Schema: labbsc_dev; Owner: -
--

ALTER TABLE ONLY labbsc_dev.labbsc_dev_asset_delete_log
    ADD CONSTRAINT labbsc_dev_asset_delete_log_pkey PRIMARY KEY (asset_delete_log_id);


--
