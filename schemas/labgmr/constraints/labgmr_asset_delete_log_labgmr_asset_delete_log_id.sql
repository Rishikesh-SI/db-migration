-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_asset_delete_log labgmr_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labgmr_asset_delete_log labgmr_asset_delete_log_id; Type: CONSTRAINT; Schema: labgmr; Owner: -
--

ALTER TABLE ONLY labgmr.labgmr_asset_delete_log
    ADD CONSTRAINT labgmr_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
