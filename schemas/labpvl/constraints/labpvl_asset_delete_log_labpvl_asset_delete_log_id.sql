-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_asset_delete_log labpvl_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labpvl_asset_delete_log labpvl_asset_delete_log_id; Type: CONSTRAINT; Schema: labpvl; Owner: -
--

ALTER TABLE ONLY labpvl.labpvl_asset_delete_log
    ADD CONSTRAINT labpvl_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
