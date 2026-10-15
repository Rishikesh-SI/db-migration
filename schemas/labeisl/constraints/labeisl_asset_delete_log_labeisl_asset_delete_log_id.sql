-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: labeisl_asset_delete_log labeisl_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labeisl_asset_delete_log labeisl_asset_delete_log_id; Type: CONSTRAINT; Schema: labeisl; Owner: -
--

ALTER TABLE ONLY labeisl.labeisl_asset_delete_log
    ADD CONSTRAINT labeisl_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
