-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_asset_delete_log labgrl_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labgrl_asset_delete_log labgrl_asset_delete_log_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_asset_delete_log
    ADD CONSTRAINT labgrl_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
