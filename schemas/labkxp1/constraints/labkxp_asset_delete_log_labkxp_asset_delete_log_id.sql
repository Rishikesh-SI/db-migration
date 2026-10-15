-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: labkxp_asset_delete_log labkxp_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labkxp_asset_delete_log labkxp_asset_delete_log_id; Type: CONSTRAINT; Schema: labkxp1; Owner: -
--

ALTER TABLE ONLY labkxp1.labkxp_asset_delete_log
    ADD CONSTRAINT labkxp_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
