-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_asset_delete_log labmi_v1_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labmi_v1_asset_delete_log labmi_v1_asset_delete_log_id; Type: CONSTRAINT; Schema: labmi_v1; Owner: -
--

ALTER TABLE ONLY labmi_v1.labmi_v1_asset_delete_log
    ADD CONSTRAINT labmi_v1_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
