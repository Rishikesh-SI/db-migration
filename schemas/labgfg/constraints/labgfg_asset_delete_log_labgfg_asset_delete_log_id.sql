-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_asset_delete_log labgfg_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labgfg_asset_delete_log labgfg_asset_delete_log_id; Type: CONSTRAINT; Schema: labgfg; Owner: -
--

ALTER TABLE ONLY labgfg.labgfg_asset_delete_log
    ADD CONSTRAINT labgfg_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
