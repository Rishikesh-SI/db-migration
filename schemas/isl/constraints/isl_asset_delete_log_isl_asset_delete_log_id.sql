-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_asset_delete_log isl_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: isl_asset_delete_log isl_asset_delete_log_id; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_asset_delete_log
    ADD CONSTRAINT isl_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
