-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_asset_delete_log labstrd_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labstrd_asset_delete_log labstrd_asset_delete_log_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_asset_delete_log
    ADD CONSTRAINT labstrd_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
