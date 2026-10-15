-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_asset_delete_log labgg_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labgg_asset_delete_log labgg_asset_delete_log_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_asset_delete_log
    ADD CONSTRAINT labgg_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
