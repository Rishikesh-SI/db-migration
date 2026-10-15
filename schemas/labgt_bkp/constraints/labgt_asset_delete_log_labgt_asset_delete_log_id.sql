-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_asset_delete_log labgt_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labgt_asset_delete_log labgt_asset_delete_log_id; Type: CONSTRAINT; Schema: labgt_bkp; Owner: -
--

ALTER TABLE ONLY labgt_bkp.labgt_asset_delete_log
    ADD CONSTRAINT labgt_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
