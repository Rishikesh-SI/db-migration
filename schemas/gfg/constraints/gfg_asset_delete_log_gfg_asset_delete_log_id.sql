-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: gfg_asset_delete_log gfg_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: gfg_asset_delete_log gfg_asset_delete_log_id; Type: CONSTRAINT; Schema: gfg; Owner: -
--

ALTER TABLE ONLY gfg.gfg_asset_delete_log
    ADD CONSTRAINT gfg_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
