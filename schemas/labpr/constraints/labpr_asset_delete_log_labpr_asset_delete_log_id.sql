-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_asset_delete_log labpr_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labpr_asset_delete_log labpr_asset_delete_log_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_asset_delete_log
    ADD CONSTRAINT labpr_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
