-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: labwskl_asset_delete_log labwskl_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labwskl_asset_delete_log labwskl_asset_delete_log_id; Type: CONSTRAINT; Schema: labwskl; Owner: -
--

ALTER TABLE ONLY labwskl.labwskl_asset_delete_log
    ADD CONSTRAINT labwskl_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
