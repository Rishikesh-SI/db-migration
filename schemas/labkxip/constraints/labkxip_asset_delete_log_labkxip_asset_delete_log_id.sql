-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_asset_delete_log labkxip_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labkxip_asset_delete_log labkxip_asset_delete_log_id; Type: CONSTRAINT; Schema: labkxip; Owner: -
--

ALTER TABLE ONLY labkxip.labkxip_asset_delete_log
    ADD CONSTRAINT labkxip_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
