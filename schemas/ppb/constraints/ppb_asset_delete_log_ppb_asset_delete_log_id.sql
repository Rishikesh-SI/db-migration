-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_asset_delete_log ppb_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: ppb_asset_delete_log ppb_asset_delete_log_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_asset_delete_log
    ADD CONSTRAINT ppb_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
