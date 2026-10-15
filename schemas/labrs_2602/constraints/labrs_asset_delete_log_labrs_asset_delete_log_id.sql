-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: labrs_asset_delete_log labrs_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labrs_asset_delete_log labrs_asset_delete_log_id; Type: CONSTRAINT; Schema: labrs_2602; Owner: -
--

ALTER TABLE ONLY labrs_2602.labrs_asset_delete_log
    ADD CONSTRAINT labrs_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
