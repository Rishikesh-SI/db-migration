-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_asset_delete_log labyho_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labdms_asset_delete_log labyho_asset_delete_log_id; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_asset_delete_log
    ADD CONSTRAINT labyho_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
