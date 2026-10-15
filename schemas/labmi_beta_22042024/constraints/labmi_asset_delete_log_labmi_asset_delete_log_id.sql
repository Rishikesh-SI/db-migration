-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_asset_delete_log labmi_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labmi_asset_delete_log labmi_asset_delete_log_id; Type: CONSTRAINT; Schema: labmi_beta_22042024; Owner: -
--

ALTER TABLE ONLY labmi_beta_22042024.labmi_asset_delete_log
    ADD CONSTRAINT labmi_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
