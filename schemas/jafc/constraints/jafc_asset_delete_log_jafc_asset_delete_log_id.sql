-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_asset_delete_log jafc_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: jafc_asset_delete_log jafc_asset_delete_log_id; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_asset_delete_log
    ADD CONSTRAINT jafc_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
