-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_asset_delete_log zeven_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: zeven_asset_delete_log zeven_asset_delete_log_id; Type: CONSTRAINT; Schema: zeven; Owner: -
--

ALTER TABLE ONLY zeven.zeven_asset_delete_log
    ADD CONSTRAINT zeven_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
