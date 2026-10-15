-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_asset_delete_log labos_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labos_asset_delete_log labos_asset_delete_log_id; Type: CONSTRAINT; Schema: labos; Owner: -
--

ALTER TABLE ONLY labos.labos_asset_delete_log
    ADD CONSTRAINT labos_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
