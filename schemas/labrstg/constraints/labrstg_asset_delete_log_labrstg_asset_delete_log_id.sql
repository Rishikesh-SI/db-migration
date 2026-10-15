-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_asset_delete_log labrstg_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labrstg_asset_delete_log labrstg_asset_delete_log_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_asset_delete_log
    ADD CONSTRAINT labrstg_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
