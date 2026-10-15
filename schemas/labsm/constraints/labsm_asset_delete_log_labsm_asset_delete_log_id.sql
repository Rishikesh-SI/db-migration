-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_asset_delete_log labsm_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labsm_asset_delete_log labsm_asset_delete_log_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_asset_delete_log
    ADD CONSTRAINT labsm_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
