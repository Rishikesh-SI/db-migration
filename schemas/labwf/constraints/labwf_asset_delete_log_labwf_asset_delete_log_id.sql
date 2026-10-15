-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_asset_delete_log labwf_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labwf_asset_delete_log labwf_asset_delete_log_id; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_asset_delete_log
    ADD CONSTRAINT labwf_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
