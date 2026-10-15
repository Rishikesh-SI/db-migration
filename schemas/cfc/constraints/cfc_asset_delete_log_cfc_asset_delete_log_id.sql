-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: cfc_asset_delete_log cfc_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: cfc_asset_delete_log cfc_asset_delete_log_id; Type: CONSTRAINT; Schema: cfc; Owner: -
--

ALTER TABLE ONLY cfc.cfc_asset_delete_log
    ADD CONSTRAINT cfc_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
