-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ttgl_asset_delete_log ttgl_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: ttgl_asset_delete_log ttgl_asset_delete_log_id; Type: CONSTRAINT; Schema: ttgl; Owner: -
--

ALTER TABLE ONLY ttgl.ttgl_asset_delete_log
    ADD CONSTRAINT ttgl_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
