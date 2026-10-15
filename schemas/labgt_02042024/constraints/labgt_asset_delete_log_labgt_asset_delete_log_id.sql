-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_asset_delete_log labgt_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labgt_asset_delete_log labgt_asset_delete_log_id; Type: CONSTRAINT; Schema: labgt_02042024; Owner: -
--

ALTER TABLE ONLY labgt_02042024.labgt_asset_delete_log
    ADD CONSTRAINT labgt_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
