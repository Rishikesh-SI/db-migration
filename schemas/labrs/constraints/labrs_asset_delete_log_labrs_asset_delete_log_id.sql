-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_asset_delete_log labrs_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labrs_asset_delete_log labrs_asset_delete_log_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_asset_delete_log
    ADD CONSTRAINT labrs_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
