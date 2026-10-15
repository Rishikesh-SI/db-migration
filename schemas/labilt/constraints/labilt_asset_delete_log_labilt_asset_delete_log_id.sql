-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_asset_delete_log labilt_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labilt_asset_delete_log labilt_asset_delete_log_id; Type: CONSTRAINT; Schema: labilt; Owner: -
--

ALTER TABLE ONLY labilt.labilt_asset_delete_log
    ADD CONSTRAINT labilt_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
