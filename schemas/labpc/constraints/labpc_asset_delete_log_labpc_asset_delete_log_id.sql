-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_asset_delete_log labpc_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labpc_asset_delete_log labpc_asset_delete_log_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_asset_delete_log
    ADD CONSTRAINT labpc_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
