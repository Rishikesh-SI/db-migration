-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_asset_delete_log labetpl_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labetpl_asset_delete_log labetpl_asset_delete_log_id; Type: CONSTRAINT; Schema: labetpl; Owner: -
--

ALTER TABLE ONLY labetpl.labetpl_asset_delete_log
    ADD CONSTRAINT labetpl_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
