-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_asset_delete_log labpkl_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labpkl_asset_delete_log labpkl_asset_delete_log_id; Type: CONSTRAINT; Schema: labpkl; Owner: -
--

ALTER TABLE ONLY labpkl.labpkl_asset_delete_log
    ADD CONSTRAINT labpkl_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
