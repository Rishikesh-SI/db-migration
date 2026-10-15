-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_asset_delete_log labmi_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labmi_asset_delete_log labmi_asset_delete_log_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_asset_delete_log
    ADD CONSTRAINT labmi_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
