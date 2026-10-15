-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_asset_delete_log stn_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: stn_asset_delete_log stn_asset_delete_log_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_asset_delete_log
    ADD CONSTRAINT stn_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
