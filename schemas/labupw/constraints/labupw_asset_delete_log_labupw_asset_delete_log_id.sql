-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_asset_delete_log labupw_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labupw_asset_delete_log labupw_asset_delete_log_id; Type: CONSTRAINT; Schema: labupw; Owner: -
--

ALTER TABLE ONLY labupw.labupw_asset_delete_log
    ADD CONSTRAINT labupw_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
