-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: labecn_v1_asset_delete_log labecn_v1_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labecn_v1_asset_delete_log labecn_v1_asset_delete_log_id; Type: CONSTRAINT; Schema: labecn_v1; Owner: -
--

ALTER TABLE ONLY labecn_v1.labecn_v1_asset_delete_log
    ADD CONSTRAINT labecn_v1_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
