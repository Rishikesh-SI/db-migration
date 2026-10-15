-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_asset_delete_log labstmp_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labstmp_asset_delete_log labstmp_asset_delete_log_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_asset_delete_log
    ADD CONSTRAINT labstmp_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
