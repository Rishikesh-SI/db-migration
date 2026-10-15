-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_asset_delete_log labbsc_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labbsc_asset_delete_log labbsc_asset_delete_log_id; Type: CONSTRAINT; Schema: labbsc_old; Owner: -
--

ALTER TABLE ONLY labbsc_old.labbsc_asset_delete_log
    ADD CONSTRAINT labbsc_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
