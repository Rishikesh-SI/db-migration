-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_asset_delete_log tcs_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: tcs_asset_delete_log tcs_asset_delete_log_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_asset_delete_log
    ADD CONSTRAINT tcs_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
