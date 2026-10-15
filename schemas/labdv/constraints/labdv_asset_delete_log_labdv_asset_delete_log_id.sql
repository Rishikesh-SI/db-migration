-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_asset_delete_log labdv_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labdv_asset_delete_log labdv_asset_delete_log_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_asset_delete_log
    ADD CONSTRAINT labdv_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
