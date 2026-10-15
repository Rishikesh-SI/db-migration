-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_asset_delete_log labkc_v1_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labkc_v1_asset_delete_log labkc_v1_asset_delete_log_id; Type: CONSTRAINT; Schema: labkc_v1_bkp; Owner: -
--

ALTER TABLE ONLY labkc_v1_bkp.labkc_v1_asset_delete_log
    ADD CONSTRAINT labkc_v1_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
