-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_asset_delete_log labtkr_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labtkr_asset_delete_log labtkr_asset_delete_log_id; Type: CONSTRAINT; Schema: labtkr_beta; Owner: -
--

ALTER TABLE ONLY labtkr_beta.labtkr_asset_delete_log
    ADD CONSTRAINT labtkr_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
