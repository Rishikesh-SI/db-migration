-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_asset_delete_log labkxp_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labstlz_asset_delete_log labkxp_asset_delete_log_id; Type: CONSTRAINT; Schema: labstlz; Owner: -
--

ALTER TABLE ONLY labstlz.labstlz_asset_delete_log
    ADD CONSTRAINT labkxp_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
