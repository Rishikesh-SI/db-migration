-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_asset_delete_log labfg_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labfg_asset_delete_log labfg_asset_delete_log_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_asset_delete_log
    ADD CONSTRAINT labfg_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
