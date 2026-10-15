-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: labkkr_asset_delete_log labkkr_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labkkr_asset_delete_log labkkr_asset_delete_log_id; Type: CONSTRAINT; Schema: labkkr_beta; Owner: -
--

ALTER TABLE ONLY labkkr_beta.labkkr_asset_delete_log
    ADD CONSTRAINT labkkr_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
