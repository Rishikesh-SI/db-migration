-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: labso_asset_delete_log labso_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labso_asset_delete_log labso_asset_delete_log_id; Type: CONSTRAINT; Schema: labso_bkp; Owner: -
--

ALTER TABLE ONLY labso_bkp.labso_asset_delete_log
    ADD CONSTRAINT labso_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
