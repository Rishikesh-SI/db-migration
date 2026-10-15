-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_asset_delete_log labwpl_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labwpl_asset_delete_log labwpl_asset_delete_log_id; Type: CONSTRAINT; Schema: labwpl; Owner: -
--

ALTER TABLE ONLY labwpl.labwpl_asset_delete_log
    ADD CONSTRAINT labwpl_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
