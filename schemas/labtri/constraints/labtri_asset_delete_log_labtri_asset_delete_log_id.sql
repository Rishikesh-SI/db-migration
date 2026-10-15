-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_asset_delete_log labtri_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labtri_asset_delete_log labtri_asset_delete_log_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_asset_delete_log
    ADD CONSTRAINT labtri_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
