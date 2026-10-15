-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: labspz_v1_asset_delete_log labspz_v1_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labspz_v1_asset_delete_log labspz_v1_asset_delete_log_id; Type: CONSTRAINT; Schema: labspz_v1; Owner: -
--

ALTER TABLE ONLY labspz_v1.labspz_v1_asset_delete_log
    ADD CONSTRAINT labspz_v1_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
