-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_asset_delete_log yho_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: yho_asset_delete_log yho_asset_delete_log_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_asset_delete_log
    ADD CONSTRAINT yho_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
