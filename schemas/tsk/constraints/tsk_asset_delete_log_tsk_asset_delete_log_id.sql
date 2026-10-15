-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_asset_delete_log tsk_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: tsk_asset_delete_log tsk_asset_delete_log_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_asset_delete_log
    ADD CONSTRAINT tsk_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
